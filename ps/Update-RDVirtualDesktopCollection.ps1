####    Example 1: Update a virtual desktop collection    ####
cd C:\
Update-RDVirtualDesktopCollection -CollectionName "Virtual Desktop pool" VirtualDesktopTemplateName "RDS-Template" -VirtualDesktopTemplateHostServer
"rdvh-1.contoso.com" -ForceLogoffTime 12:00am -DisableVirtualDesktopRollback -VirtualDesktopPasswordAge 31 -ConnectionBroker "rdcb.contoso.com"

#This command updates the virtual desktop collection named "Virtual Desktop pool" with the virtual desktop template named "RDS-Template" on the host server named "rdvh-1.contoso.com".
#The command specifies that the server ends the session if the update operation is still running at 12:00am. The command disables the rollback of a virtual desktop deployment and specifies that the server forces a password update for the computer account for a virtual desktop after 31 days.