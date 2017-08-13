# SimpleTemplates
A basic template system for PowerShell, based on here-strings and stuff. Module can be downloaded from the PSGallery 

This technique allows the flexibility to generate markup in your favourite text editor, and then embedding PowerShell expressions throughout your markup. The only requirement is that the template files you create should be named with .pshtml extension. If your using VS Code to edit powershell scripts, just open up the new .pshtml file and change the language mode to HTML.

How to use:
1. Install-Module SimpleTemplates
2. Render-Template .\index.pshtml | out-file .\index.html

## How to pass in variables:
Render-Template has a parameter for user data that needs to be passed into the template. It is best to use this as a hashtable, so that the Render-Template function can expand each hashtable element as a new Variable. Variables will have function scope, and will not 
be available in recursive calls to Render-Template.

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
    
