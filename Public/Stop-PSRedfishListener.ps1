function Stop-PSredfishListener
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)]
        [String]
        $EventDestination
    )

    $resp = Invoke-WebRequest -UseBasicParsing -Uri "https://${EventDestination}/end" -ErrorAction SilentlyContinue
    if ($resp)
    {
        Write-Verbose -Message 'Event Listener stopped!'
    }
    else
    {
        Write-Error -Message 'Event listener was either not found or not stopped successfully.'    
    }
}
