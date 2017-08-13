# SimpleTemplates
A basic template system for PowerShell, based on here-strings and stuff. Module can be downloaded from the PSGallery 

Internally, SimpleTemplates works by wrrapping text files into here strings. This technique allows you the flexibility to generate markup in your favourite text editor, and then embed PowerShell expressions throughout your markup. The only requirement is that the template files you create should be named with the file .pshtml extension. If your using VS Code to edit powershell scripts, just open up the new .pshtml file and change the language mode to HTML. pshtml files are just like HTML files, but with powershell code embedded in them, so webservers shouldnt serve these files by default.

How to use:
1. Install-Module SimpleTemplates
2. Render-Template .\index.pshtml | out-file .\index.html

## Passing in variables:
Render-Template has a parameter for user data that must be passed into the template before rendering. It is best to use a hashtable for this, so that the Render-Template function can expand each hashtable element as a new Variable. Hashtables are not essential, but should help keep your html code clean. Variables will have function scope, and will not be available in recursive calls to Render-Template.

An example in powershell:

$data = @{'PageTitle' = 'My webpage';}
Render-Template .\index.pshtml -Data $data

will be available to use in .pshtml file as:

    <html>
    <head>
        <title> $PageTitle </title>
    </head>
    <body>...</body>
    </html>
     
## Powershell Expressions just need to be enclosed in $(). 

    <html>
    <head>
        <title></title>
    </head>
    <body><h2>The current date and time is: $([datetime]::Now) </h2></body>
    </html>
    

## Nested Templates can be rendered by calling Render-Template in the template itself.

    <html>
    <head>
        <title></title>
    </head>
    <body>$(Render-Template .\Menu.pshtml) </h2></body>
    </html>

## If you want to have seperate templates for headers/footers/content/menus etc then this can be done by loading temlates side-by-side

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Document</title>
    </head>
    <body>
        $(Render-Template .\Menu.pshtml)
        $(Render-Template .\Content.pshtml @{'Number1' = 1;'Number2' = 2;})    
    </body>
    </html>
