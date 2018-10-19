# Remove-PSRedfishEventListenerHttpsBinding

This command removes all SSL certificate bindings from the local system.

> Caution: DO NOT use this command if you have other SSL certificate bindings on the system that other applications depend on.

This command has no parameters.

## Examples

```powershell
Remove-PSRedfishEventListenerHttpsBinding -Verbose
```

The following command removes all SSL certificate bindings from the system. This displays a confirmation prompt to indicate that all SSL certificate bindings will be removed.