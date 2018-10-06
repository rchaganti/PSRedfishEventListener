function Remove-PSRedfishListenerHttpsBinding
{
    [CmdletBinding()]
    param 
    (

    )

    Write-Verbose -Message 'Removing IP HTTPS binding'    
    Remove-NetIPHttpsCertBinding -Verbose
}
