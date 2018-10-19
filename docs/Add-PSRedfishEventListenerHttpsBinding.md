# Add-PSRedfishEventListenerHttpsBinding

This command adds an SSL certificate binding for the HTTPS event listener for Redfish events. This command has the following parameters.

| Parameter Name | Description                                                  | Mandatory? |
| -------------- | ------------------------------------------------------------ | ---------- |
| IPAddress      | Specifies the IP address to which the event listener is bound to. Default value is 0.0.0.0. | No         |
| Port           | Specifies the port on which the event listener is listening to. Default value 443. | No         |
| Thumbprint     | Specifies the SSL certificate thumbprint that be should be bound to the event listener socket. | Yes        |

## Examples

```powershell
Add-PSRedfishEventListenerHttpsBinding -Thumbprint EABECF8E790A72D24166DC54FAA2930453BECAB2 -Verbose
```

The above command will bind the certificate represented by the specified thumbprint to listener running locally and listening on port 443.

```powershell
Add-PSRedfishEventListenerHttpsBinding -IPAddress 172.16.102.76 -Port 9090 -Thumbprint EABECF8E790A72D24166DC54FAA2930453BECAB2 -Verbose
```

The above command will bind the certificate represented by the specified thumbprint to listener running at 172.16.102.76 and listening on port 9090.

