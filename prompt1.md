Write a batch file for windows: 
1. Download the file from `https://raw.hellogithub.com/hosts` to local.
2. Open the hosts file in `C:\Windows\System32\drivers\etc\hosts`, find the marker lines started with `### Github Start` and `### Github End`.
3. If the marker lines are all found, replace all the lines between them with content in the downloaded file; please preserve all lines (including the blank lines) outside of the marker lines. 
4. If either of the marker lines were not found, print a message and append all content in the downloaded file to the end of the hosts file. 
5. Save the new file to `C:\Windows\System32\drivers\etc\hosts`, ignore the original one. 

Note the batch file grammer of quotes and variables.
