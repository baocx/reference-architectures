# N-tier application with SQL Server

This reference architecture shows how to deploy VMs and a virtual network configured for an N-tier application, using SQL Server on Windows for the data tier.

![n-tier-sql-server-image](https://docs.microsoft.com/azure/architecture/reference-architectures/n-tier/images/n-tier-sql-server.png)

For deployment instructions and guidance about best practices, see the article [N-tier application with SQL Server](https://docs.microsoft.com/azure/architecture/reference-architectures/n-tier/n-tier-sql-server) on the Azure Architecture Center.

The deployment depends on [Microsoft Azure CLI](https://github.com/Azure/azure-cli), a command line tool that simplifies deployment of Azure resources.

Run the following command in a powershell terminal to deploy the architecture:

```powershell
az login
./n-tier-windows.ps1
```
