$Output = Invoke-RestMethod https://api.github.com/repos/pulumi/pulumi/pulls?state=all
$LastSevenDaysPRs = $Output | Where-Object {[DateTime]($_.created_at) -gt  (Get-Date).AddDays(-7)} `
                    | select created_at,state,html_url,title

Write-Output $LastSevenDaysPRs

Send-MailMessage -From "abc@org.com" -To "xyz@org.com" -Subject "Last 7 Days PR report" -Body "$LastSevenDaysPRs" -SmtpServer "smtp.org.com" -Credential org.com\mailuser -UseSsl