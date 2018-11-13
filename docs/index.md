# Redfish Event Listener in PowerShell

The Redfish specification supports event mechanism through which the target redfish devices can send events from different components in the system to an event listener. This project provides an event listener that is created in native PowerShell.

This module contains the following commands.

| Command Name                              | Description                                                  |
| ----------------------------------------- | ------------------------------------------------------------ |
| Add-PSRedfishEventListenerHttpsBinding    | This command adds an SSL certificate binding for the HTTPS event listener for Redfish events. This command has the following parameters. |
| Get-PSRedfishEventSubscription            | This command gets all the event subscriptions from a Redfish device. |
| Remove-PSRedfishEventListenerHttpsBinding | This command removes all SSL certificate bindings from the local system. |
| Register-PSRedfishEventSubscription       | This command registers a redfish device with an event listener. A given redfish can send events to multiple event listeners. |
| Start-PSRedfishEventListener              | The `Start-PSRedfishListener` command starts the Redfish event listener (HTTPS) on the local host. This HTTPS listener requires an SSL certificate binding and it needs to be done as a prerequisite and can be performed using the `Add-PSRedfishListenerHttpsBinding` command. |
| Stop-PSRedfishEventListener               | The `Stop-PSRedfishEventListener` commands stop the event listener that was started using the `Start-PSRedfishEventListener` command either locally or on a remote system. |
| Send-PSRedfishTestEvent                   | As per the Redfish eventing specification, each Redfish device should support submitting a test event to the listener for testing purposes. This is generally used for validation purposes that the Redfish device can indeed send the events to configured destination and the listener can process the received event messages as desired. |
| Unregister-PSRedfishEventSubscription     | This command will remove an event subscription from the Redfish device. |

