function Remove-PSRedfishEventListenerHttpsBinding
{
    [CmdletBinding(SupportsShouldProcess = $true,ConfirmImpact = 'High')]
    param 
    (

    )

    if ($PSCmdlet.ShouldProcess('localhost','remove all SSL certificate bindings'))
    {
        Write-Verbose -Message 'Removing IP HTTPS binding'    
        Remove-NetIPHttpsCertBinding -Verbose
    }
}
