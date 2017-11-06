<# ==== MAIN MENU ====#>
function Main-Menu 
{
    do
    {
        Write-Host "========================================="
		Write-Host "     Jenkins User Management Utility     "
		Write-Host "       Created by: JCANAS3 Oct2017       "
		Write-Host "========================================="
		Write-Host "            *** MAIN MENU ***            "
		Write-Host "Executed By: $userlog @ $timelog         "
		Write-Host "========================================="
		Write-Host "1. Remove User Utility `n2. ADD User Utility `n3. Exit "
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!"  } 
		Switch ($input) {
            "1" {clear;rem-client}
            "2" {clear;add-client}
            "3" {clear;Exit}
        }
    }
    until (1..3 -contains $input) 
}

<# ==== REMOVE User Utility Client MENU ====#>

function rem-client 
{
    do
    {
        Write-Host "REMOVE User Utility Client MENU"
		Write-Host "1. MEMIC `n2. SwissRE `n3. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {clear;rem-mem-menu}
            "2" {clear;rem-sre-menu}
            "3" {clear;Main-Menu}
        }
    }
    until (1..3 -contains $input) 
}

<# ==== ADD User Utility Role MENU ====#>

function add-client 
{
    do
    {
        Write-Host "ADD Utility MENU"
		Write-Host "1. Memic `n2. SwissRE `n3. Return to Main Menu"
        $input = read-host [Enter Selection]
        Switch ($input) {
            "1" {clear;addrole-mem-menu}
            "2" {clear;addrole-sre-menu}
            "3" {clear;Main-Menu}
        }
    }
    until (1..3 -contains $input) 
}

<# ==== REMOVE User Utility Menu Per Client Environment ===#>

function rem-mem-menu
{
    do
    {
        Write-Host "REMOVE User Utility for MEMIC MENU"
		Write-Host "1. All MEMIC Jobs `n2. <#MEMIC PRD Jobs `n3. MEMIC STG Jobs`n4. MEMIC UAT Jobs`n5.#> Back to Previous Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {clear;rem-mem_all-job}
            "2" {clear;rem-mem_prd-job}
			"3" {clear;rem-mem_stg-job}
			"4" {clear;rem-mem_uat-job}
            "5" {clear;rem-client}
        }
    }
    until (1..5 -contains $input) 
}

function rem-sre-menu
{
    do
    {
        Write-Host "REMOVE User Utility for SWISSRE MENU"
		Write-Host "1. All SWISSRE Jobs `n2. SWISSRE PRD Jobs `n3. SWISSRE STG Jobs`n4. SWISSRE UAT Jobs`n5. Return to Previous Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {clear;rem-sre_all-menu}
            "2" {clear;rem-sre_prd-menu}
			"3" {clear;rem-sre_stg-menu}
			"4" {clear;rem-sre_uat-menu}
            "5" {clear;rem-client}
        }
    }
    until (1..5 -contains $input) 
}

<# ==== ADD User Utility Menu Per Client Per Role ===#>

function addrole-mem-menu
{
    do
    {
        Write-Host "ADD User Management - User Roles MENU"
		Write-Host "1. ADMIN User `n2. Read Only User `n3. Collaborator User `n4. Operator Role `n5. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {clear;add-mem-admin}
            "2" {clear;add-mem-read}
            "3" {clear;add-mem-collab}
			"4" {clear;add-mem-operate}
			"5" {clear;add-usr}
        }
    }
    until (1..5 -contains $input) 
}

function addrole-sre-menu 
{
    do
    {
        Write-Host "User ADD Management MENU"
		Write-Host "1. ADMIN Role `n2. Read Only Role `n3. Collaborator Role`n4. Operator Role`n5. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {clear;add-sre-admin}
            "2" {clear;add-sre-read}
			"3" {clear;add-sre-collab}
			"4" {clear;add-sre-operate}
			"5" {clear;add-usr}
        }
    }
    until (1..5 -contains $input) 
}

<# ==== Remove User in Memic Jobs ====#>

function rem-mem_all-job
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$userrem = read-host [Enter the username to remove]
		$cdmemprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_PRD\jobs"
		$cdmemstg = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_STG\jobs"
		$cdmemuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_UAT\jobs"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
		
	<# Script to remove $userrem from MEMPRD jobs config.xml and update the Jenkins UI #>
	<#Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemprd\MEMPRD-Backout-PRDPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memprdconfig1.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfig1.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		Get-Content $cdmemprd\MEMPRD-Backout-PRDSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memprdconfig2.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfig2.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		Get-Content $cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memprd3config3.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfig3.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml
		
		Get-Content $cdmemprd\MEMPRD-Deploy-PRDSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memprd4config4.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfig4.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml
		
		Get-Content $cdmemprd\MEMPRD-Deploy-PRDSQL\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memprd5config5.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfig5.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
			
		Write-Host "You have remove $userrem in MEMIC PRD jobs"
		pause
	
	<# Script to remove $userrem from MEMSTG jobs config.xml and update the Jenkins UI #>
	<# Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemstg\MEMSTG-Backout-STGPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memstgconfig1.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfig1.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Backout-STGPRE/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Backout-STGSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memstgconfig2.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfig2.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Backout-STGSRV/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Deploy-STGPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memstgconfig3.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfig3.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Deploy-STGPRE/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Deploy-STGSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memstgconfig4.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfig4.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Deploy-STGSRV/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Deploy-STGSQL\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memstgconfig5.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfig5.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Deploy-STGSQL/config.xml
			
	
		Write-Host "You have remove $userrem in MEMIC STG jobs"
		pause
	
	<# Script to remove $userrem from MEMUAT jobs config.xml and update the Jenkins UI #>
	<# Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemuat\MEMUAT-Backout-UATPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memuatconfig1.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfig1.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Backout-UATPRE/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Backout-UATSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memuatconfig2.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfig2.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Backout-UATSRV/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Deploy-UATPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memuatconfig3.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfig3.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Deploy-UATPRE/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Deploy-UATSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memuatconfig4.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfig4.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Deploy-UATSRV/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Deploy-UATSQL\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\memuatconfig5.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfig5.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Deploy-UATSQL/config.xml
			
		Write-Host "You have remove $userrem in MEMIC UAT jobs"
				
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Remove $userrem in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and remove $userrem in PRD, UAT & STG jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
		pause
		rem-client
}

function rem-sre_all-job
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$userrem = read-host [Enter username to remove]
		$cdsreprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs\"
		$cdsreuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Script to remove $userrem from config.xml and update the Jenkins UI #>
    <# Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemic\SREUAT-Deploy-PRDPRE\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\sreuatconfig1.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfig1.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
	
		Get-Content $cdmemic\SREUAT-Deploy-PRDSRV\config.xml | where-Object{$_ -notmatch ':$userrem'} | Out-File $cdtempdir\sreuatconfig2.xml 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfig2.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
	
		write-host "You have remove $userrem in SwissRE UAT jobs"
		pause
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Remove $userrem in all SwissRE Jobs"
		$Body = "Executed by $userlog at $timelog and remove $userrem in UAT jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
		pause
		rem-client
}

<# ==== ADD User Roles in Memic Jobs ====#>

function add-mem-admin
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdmemprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_PRD\jobs\"
		$cdmemstg = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_STG\jobs\"
		$cdmemuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Admin Access on MEMPRDjobs #>
		[xml]$xml = gc "`$cdmemprd\MEMPRD-Backout-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memprdconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/SwissRE_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
		
		[xml]$xml = gc "`$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memprdconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml"
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memprdconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memprdconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memprdconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
		
	<# Admin Access on MEMSTG jobs #>
		[xml]$xml = gc "`$cdmemstg\MEMSTG-Backout-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memstgconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/SwissRE_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
		
		[xml]$xml = gc "`$cdmemstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memstgconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemstg\MEMSTG-Deploy-STGPRE\config.xml"
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memstgconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memstgconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memstgconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
		
	<# Admin Access on MEMUAT jobs #>
		[xml]$xml = gc "`$cdmemuat\MEMUAT-Backout-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memuatconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/SwissRE_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
		
		[xml]$xml = gc "`$cdmemuat\MEMUAT-Backout-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memuatconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemuat\MEMUAT-Deploy-UATPRE\config.xml"
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memuatconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmempuat\MEMUAT-Backout-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memuatconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemuat\MEMUAT-Backout-UATSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\memuatconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
		
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as ADMIN Role in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
clear
addrole-mem-menu
}

function add-mem-read
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdmemprd = 'C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_PRD\jobs\'
		$cdmemstg = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_STG\jobs\"
		$cdmemuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# READ Access MEMPRD jobs #>
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memprdconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memprdconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memprdconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memprdconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memprdconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# READ Access MEMSTG jobs #>	
		[xml]$xml = gc "$cdmemprd\MEMSTG-Backout-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memstgconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memstgconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemstg\MEMSTG-Deploy-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memstgconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memstgconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memstgconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# READ Access MEMUAT jobs #>
		[xml]$xml = gc "$cdmemuat\MEMUAT-Backout-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memuatconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemuat\MEMUAT-Backout-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memuatconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmempuat\MEMUAT-Deploy-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memuatconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemuat\MEMUAT-Backout-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memuatconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemuat\MEMUAT-Backout-UATSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\memuatconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memuatconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Read Only Role in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
clear
addrole-mem-menu
}

function add-mem-collab
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdmemprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_PRD\jobs\"
		$cdmemstg = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_STG\jobs\"
		$cdmemuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Collaborator Access MEMPRD jobs #>
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Collaborator Access MEMSTG jobs #>
		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memstgconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmempstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memstgconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemstg\MEMSTG-Deploy-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memstgconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memstgconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memstgconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Collaborator Access MEMUAT jobs #>
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\memprdconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Collaborator Role in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
clear
addrole-mem-menu
}

function add-mem-operate
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdmemprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_PRD\jobs\"
		$cdmemstg = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_STG\jobs\"
		$cdmemuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Operator Access MEMPRD jobs #>
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Operator Access MEMSTG jobs #>
		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memstgconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmempstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memstgconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemstg\MEMSTG-Deploy-STGPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memstgconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memstgconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemstg\MEMSTG-Backout-STGSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memstgconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memstgconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Opeartor Access MEMUAT jobs #>
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		[xml]$xml = gc "$cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigC.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigC.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigD.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigD.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSRV/config.xml

		[xml]$xml = gc "$cdmemprd\MEMPRD-Backout-PRDSQL\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\memprdconfigE.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\memprdconfigE.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Operator Role in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
clear
addrole-mem-menu
}

<# ==== ADD User Roles in SwissRE Jobs ====#>

function add-sre-admin
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdsreprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs\"
		$cdsreuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Admin Access on all SREPRD jobs #>
	
	<# Admin Access on all SRESTG jobs #>
	
	<# Admin Access on all SREUAT jobs #>
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\sreuatconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
	
		[xml]$xml = gc "`$cdsreuat\SREUAT-Deploy-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
		$new5 = $xml.createElement("permission")
		[void]$new5.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
		$new6 = $xml.createElement("permission")
		[void]$new6.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new7 = $xml.createElement("permission")
		[void]$new7.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new8 = $xml.createElement("permission")
		[void]$new8.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new9 = $xml.createElement("permission")
		[void]$new9.set_InnerText("hudson.model.Item.Read:$useradd")
		$new10 = $xml.createElement("permission")
		[void]$new10.set_InnerText("hudson.model.Item.Delete:$useradd")
		$new11 = $xml.createElement("permission")
		[void]$new11.set_InnerText("hudson.model.Item.Build:$useradd")
		$new12 = $xml.createElement("permission")
		[void]$new12.set_InnerText("hudson.model.Item.Move:$useradd")
		$new13 = $xml.createElement("permission")
		[void]$new13.set_InnerText("hudson.model.Item.Discover:$useradd")
		$new14 = $xml.createElement("permission")
		[void]$new14.set_InnerText("hudson.model.Run.Delete:$useradd")
		$new15 = $xml.createElement("permission")
		[void]$new15.set_InnerText("hudson.model.Run.Replay:$useradd")
		$new16 = $xml.createElement("permission")
		[void]$new16.set_InnerText("hudson.model.Run.Update:$useradd")
		$new17 = $xml.createElement("permission")
		[void]$new17.set_InnerText("hudson.scm.SCM.Tag:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		[void]$parent.appendChild($new5)
		[void]$parent.appendChild($new6)
		[void]$parent.appendChild($new7)
		[void]$parent.appendChild($new8)
		[void]$parent.appendChild($new9)
		[void]$parent.appendChild($new10)
		[void]$parent.appendChild($new11)
		[void]$parent.appendChild($new12)
		[void]$parent.appendChild($new13)
		[void]$parent.appendChild($new14)
		[void]$parent.appendChild($new15)
		[void]$parent.appendChild($new16)
		[void]$parent.appendChild($new17)
		$xml.save("$cdtempdir\sreuatconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATSRV/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Admin Role in all SRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"	
clear
addrole-sre-menu
}

function add-sre-read
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdsreprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs\"
		$cdsreuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# READ Access on all SREPRD jobs #>
	
	<# READ Access on all SREstg jobs #>

	<# READ Access on all SREUAT jobs #>
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\sreuatconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
		
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
		[void]$parent.appendChild($new)
		$xml.save("$cdtempdir\sreuatconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATRV/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Read Role in all SRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"	
clear
addrole-sre-menu
}

function add-sre-collab
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdsreprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs\"
		$cdsreuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Collaborator Access on all SREPRD jobs #>
	
	<# Collaborator Access on all SRESTG jobs #>
	
	<# Collaborator Access on all SREUAT jobs #>
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\sreuatconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
		
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Configure:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Read:$useradd")
		$new4 = $xml.createElement("permission")
		[void]$new4.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		[void]$parent.appendChild($new4)
		$xml.save("$cdtempdir\sreuatconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATSRV/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Collaborator Role in all SRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"	
clear
addrole-sre-menu
}

function add-sre-operate
{
		write-host "Please input properly!"
	<# Input Variables #>
		$timelog = get-date -format g
		$useradd = read-host [Enter the username to add]
		$cdsreprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs\"
		$cdsreuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs\"
		$cdtempdir = "C:\temp\jnkbak"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Collaborator Access on all SREPRD jobs #>
	
	<# Collaborator Access on all SRESTG jobs #>
	
	<# Collaborator Access on all SREUAT jobs #>
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATPRE\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\sreuatconfigA.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigA.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
		
		[xml]$xml = gc "$cdsreuat\SREUAT-Deploy-UATSRV\config.xml"
		$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
		$new = $xml.createElement("permission")
		[void]$new.set_InnerText("hudson.model.Item.Workspace:$useradd")
		$new1 = $xml.createElement("permission")
		[void]$new1.set_InnerText("hudson.model.Item.Cancel:$useradd")
		$new2 = $xml.createElement("permission")
		[void]$new2.set_InnerText("hudson.model.Item.Read:$useradd")
		$new3 = $xml.createElement("permission")
		[void]$new3.set_InnerText("hudson.model.Item.Build:$useradd")
		[void]$parent.appendChild($new)
		[void]$parent.appendChild($new1)
		[void]$parent.appendChild($new2)
		[void]$parent.appendChild($new3)
		$xml.save("$cdtempdir\sreuatconfigB.xml")
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file=$cdtempdir\sreuatconfigB.xml --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATSRV/config.xml
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Operator Role in all SRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"	
clear
addrole-sre-menu
}

$timelog = get-date -format g
$userlog = read-host [Enter your short name "e.g. jcanas3"]
Main-Menu
clear
