param(
    [Parameter(Mandatory)]
    [ValidateSet(“all”,”open”,”closed”)]
    [String]$State,
#    [String]$GitHubRepoUrl,
    [Parameter(Mandatory)]
    [Int]$SinceLastNumberOfDays
)

$Output = Invoke-RestMethod "https://api.github.com/repos/pulumi/pulumi/pulls?state=$State"
$PRSearchResult = $Output | Where-Object {[DateTime]($_.created_at) -gt (Get-Date).AddDays(0-$SinceLastNumberOfDays)} `
                    | select created_at,state,html_url,title

Write-Output $PRSearchResult

Send-MailMessage -From "abc@org.com" -To "xyz@org.com" -Subject "Last $SinceLastNumberOfDays Days PR report" -Body `
                    "$PRSearchResult" -SmtpServer "smtp.org.com" -Credential org.com\mailuser -UseSsl
