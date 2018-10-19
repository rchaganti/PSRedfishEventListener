function Add-PSRedfishListenerHttpsBinding
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [string]
        $IPAddress = '0.0.0.0',

        [Parameter()]
        [Int]
        $Port = 443,

        [Parameter(Mandatory = $true)]
        [String]
        $Thumbprint
    )

    $ipPort = "${IPAddress}:${Port}"
    $guid = (New-Guid).Guid

    Add-NetIPHttpsCertBinding -IpPort $ipPort -CertificateHash $Thumbprint -CertificateStoreName 'My' -ApplicationId "{$guid}" -NullEncryption $false

}