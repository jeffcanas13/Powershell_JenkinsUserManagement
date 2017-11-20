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
	Write-Host "1. Remove User Utility `n2. ADD User Utility `nX. Exit "
    $input = read-host [Enter Selection]
	IF([string]::IsNullOrWhiteSpace($input)) {            
	Write-Host "Invalid Blank Input!!!"            
	} else {            
	Write-Host "You choose $input!!!"  }
    pause
    clear 
	Switch ($input) {
            "1" {clear;rem-client}
            "2" {clear;add-client}
            "x" {clear;Exit}
        }
    }
    until ($input -eq "x") 
}

<# ==== REMOVE User Utility Client MENU ====#>

function rem-client 
{
    do
    {
        Write-Host "REMOVE User Utility Client MENU"
		Write-Host "1. MEMIC `n2. SwissRE `nJ. Restart Jenkins Service `nR. Return to Main Menu"
        $input = read-host [Enter Selection]
		IF([string]::IsNullOrWhiteSpace($input)) {            
		Write-Host "Invalid Blank Input!!!"            
		} else {            
		Write-Host "You choose $input!!!" }
        pause
        clear
			
	Switch ($input) {
            "1" {clear;rem-mem-menu}
            "2" {clear;rem-sre-menu}
			"J" {clear;write-host "Press Enter to restart Jenkins PRD";pause;Restart-Service Jenkins;write-host "Jenkins PRD is restarting...";Get-Service Jenkins;pause}
            "R" {clear;Main-Menu}
        }
    }
    until ($input -eq "r")
}

<# ==== ADD User Utility Role MENU ====#>

function add-client 
{
    do
    {
        Write-Host "ADD Utility MENU"
	Write-Host "1. Memic `n2. SwissRE `nJ. Restart Jenkins Service `nR. Return to Main Menu"
        $input = read-host [Enter Selection]
        IF([string]::IsNullOrWhiteSpace($input)) {            
		Write-Host "Invalid Blank Input!!!"            
		} else {            
		Write-Host "You choose $input!!!" }
        pause
        clear
		
	Switch ($input) {
            "1" {clear;addrole-mem-menu}
            "2" {clear;addrole-sre-menu}
			"J" {clear;write-host "Press Enter to restart Jenkins PRD";pause;Restart-Service Jenkins;write-host "Jenkins PRD is restarting...";Get-Service Jenkins;pause}
            "R" {clear;Main-Menu}
        }
    }
    until ($input -eq "r") 
}

<# ==== REMOVE User Utility Menu Per Client Environment ===#>

function rem-mem-menu
{
    do
    {
    Write-Host "REMOVE User Utility for MEMIC MENU"
	Write-Host "1. All MEMIC Jobs `nR. Back to Previous Menu"
	$input = read-host [Enter Selection]
	IF([string]::IsNullOrWhiteSpace($input)) {            
		Write-Host "Invalid Blank Input!!!"            
		} else {            
		Write-Host "You choose $input!!!" }
	    pause
        clear
	Switch ($input) {
        "1" {clear;rem-mem_all-job}
        "R" {clear;rem-client}
        }
    }
    until ($input -eq "r") 
}

function rem-sre-menu
{
    do
    {
        Write-Host "REMOVE User Utility for SWISSRE MENU"
	Write-Host "1. All SWISSRE Jobs `nR. Return to Previous Menu"
        $input = read-host [Enter Selection]
		IF([string]::IsNullOrWhiteSpace($input)) {            
		Write-Host "Invalid Blank Input!!!"            
		} else {            
		Write-Host "You choose $input!!!" }
	    pause
        clear	
	Switch ($input) {
            "1" {clear;rem-sre_all-job}
            "R" {clear;rem-client}
        }
    }
    until ($input -eq "r") 
}

<# ==== ADD User Utility Menu Per Client Per Role ===#>

function addrole-mem-menu
{
    do
    {
        Write-Host "ADD User Management - User Roles MENU"
		Write-Host "1. ADMIN User `n2. Read Only User `n3. Collaborator User `n4. Operator Role `nR. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "You choose $input!!!" }
	        pause
            clear
		Switch ($input) {
            "1" {clear;add-mem-admin}
            "2" {clear;add-mem-read}
            "3" {clear;add-mem-collab}
			"4" {clear;add-mem-operate}
			"R" {clear;add-client}
        }
    }
    until ($input -eq "r") 
}

function addrole-sre-menu 
{
    do
    {
        Write-Host "User ADD Management MENU"
		Write-Host "1. ADMIN Role `n2. Read Only Role `n3. Collaborator Role`n4. Operator Role`nR. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "You choose $input!!!" }
	        pause
            clear
		Switch ($input) {
            "1" {clear;add-sre-admin}
            "2" {clear;add-sre-read}
			"3" {clear;add-sre-collab}
			"4" {clear;add-sre-operate}
			"R" {clear;add-client}
        }
    }
    until ($input -eq "r") 
}

<# ==== Remove User in Memic Jobs ====#>

function rem-mem_all-job
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$userrem = read-host [Enter the username to remove]
	
		
	<# Script to remove $userrem from MEMIC jobs config.xml and update the Jenkins UI #>
	<# Command to backup config.xml in each & every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss-hhss))
			}
	<# Command to update each & every config.xml with $userrem remove from the content #> 
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			$content = Get-Content $_.FullName
			$content | where-Object{$_ -notmatch ':INF_jnktstusr01'} | Out-File ($_.FullName)
			}
		
	<# Command to backup config.xml in each & every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss-hhss))
			}
	<# Command to update each & every config.xml with $userrem remove from the content #> 
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			$content = Get-Content $_.FullName
			$content | where-Object{$_ -notmatch ':INF_jnktstusr01'} | Out-File ($_.FullName)
			}
			
	<# Command to backup config.xml in each & every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss-hhss))
			}
	<# Command to update each & every config.xml with $userrem remove from the content #> 
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			$content = Get-Content $_.FullName
			$content | where-Object{$_ -notmatch ':INF_jnktstusr01'} | Out-File ($_.FullName)
			}

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
		Write-Host "You have staged to remove $userrem in MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause
				
clear
rem-client
}

function rem-sre_all-job
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$userrem = read-host [Enter the username to remove]
	
		
	<# Script to remove $userrem from MEMIC jobs config.xml and update the Jenkins UI #>
	<# Command to backup config.xml in each & every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss-hhss))
			}
	<# Command to update each & every config.xml with $userrem remove from the content #> 
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			$content = Get-Content $_.FullName
			$content | where-Object{$_ -notmatch ':INF_jnktstusr01'} | Out-File ($_.FullName)
			}
		
	<# Command to backup config.xml in each & every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss-hhss))
			}
	<# Command to update each & every config.xml with $userrem remove from the content #> 
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			$content = Get-Content $_.FullName
			$content | where-Object{$_ -notmatch ':INF_jnktstusr01'} | Out-File ($_.FullName)
			}
			
	<# Command to backup config.xml in each & every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss-hhss))
			}
	<# Command to update each & every config.xml with $userrem remove from the content #> 
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			$content = Get-Content $_.FullName
			$content | where-Object{$_ -notmatch ':INF_jnktstusr01'} | Out-File ($_.FullName)
			}

	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Remove $userrem in all SwissRE Jobs"
		$Body = "Executed by $userlog at $timelog and remove $userrem in PRD, UAT & STG jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to remove $userrem in MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause
				
clear
rem-client	
}

function add-mem-admin
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
			$new1 = $xml.createElement("permission")
			[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
			$new2 = $xml.createElement("permission")
			[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
			$new3 = $xml.createElement("permission")
			[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
			$new4 = $xml.createElement("permission")
			[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
			$new5 = $xml.createElement("permission")
			[void]$new5.set_InnerText("hudson.model.Item.Workspace:$useradd")
			$new6 = $xml.createElement("permission")
			[void]$new6.set_InnerText("hudson.model.Item.Configure:$useradd")
			$new7 = $xml.createElement("permission")
			[void]$new7.set_InnerText("hudson.model.Item.Cancel:$useradd")
			$new8 = $xml.createElement("permission")
			[void]$new8.set_InnerText("hudson.model.Item.Read:$useradd")
			$new9 = $xml.createElement("permission")
			[void]$new9.set_InnerText("hudson.model.Item.Delete:$useradd")
			$new10 = $xml.createElement("permission")
			[void]$new10.set_InnerText("hudson.model.Item.Build:$useradd")
			$new11 = $xml.createElement("permission")
			[void]$new11.set_InnerText("hudson.model.Item.Move:$useradd")
			$new12 = $xml.createElement("permission")
			[void]$new12.set_InnerText("hudson.model.Item.Discover:$useradd")
			$new13 = $xml.createElement("permission")
			[void]$new13.set_InnerText("hudson.model.Run.Delete:$useradd")
			$new14 = $xml.createElement("permission")
			[void]$new14.set_InnerText("hudson.model.Run.Replay:$useradd")
			$new15 = $xml.createElement("permission")
			[void]$new15.set_InnerText("hudson.model.Run.Update:$useradd")
			$new16 = $xml.createElement("permission")
			[void]$new16.set_InnerText("hudson.scm.SCM.Tag:$useradd")
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
			$new1 = $xml.createElement("permission")
			[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
			$new2 = $xml.createElement("permission")
			[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
			$new3 = $xml.createElement("permission")
			[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
			$new4 = $xml.createElement("permission")
			[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
			$new5 = $xml.createElement("permission")
			[void]$new5.set_InnerText("hudson.model.Item.Workspace:$useradd")
			$new6 = $xml.createElement("permission")
			[void]$new6.set_InnerText("hudson.model.Item.Configure:$useradd")
			$new7 = $xml.createElement("permission")
			[void]$new7.set_InnerText("hudson.model.Item.Cancel:$useradd")
			$new8 = $xml.createElement("permission")
			[void]$new8.set_InnerText("hudson.model.Item.Read:$useradd")
			$new9 = $xml.createElement("permission")
			[void]$new9.set_InnerText("hudson.model.Item.Delete:$useradd")
			$new10 = $xml.createElement("permission")
			[void]$new10.set_InnerText("hudson.model.Item.Build:$useradd")
			$new11 = $xml.createElement("permission")
			[void]$new11.set_InnerText("hudson.model.Item.Move:$useradd")
			$new12 = $xml.createElement("permission")
			[void]$new12.set_InnerText("hudson.model.Item.Discover:$useradd")
			$new13 = $xml.createElement("permission")
			[void]$new13.set_InnerText("hudson.model.Run.Delete:$useradd")
			$new14 = $xml.createElement("permission")
			[void]$new14.set_InnerText("hudson.model.Run.Replay:$useradd")
			$new15 = $xml.createElement("permission")
			[void]$new15.set_InnerText("hudson.model.Run.Update:$useradd")
			$new16 = $xml.createElement("permission")
			[void]$new16.set_InnerText("hudson.scm.SCM.Tag:$useradd")
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
			$new1 = $xml.createElement("permission")
			[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
			$new2 = $xml.createElement("permission")
			[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
			$new3 = $xml.createElement("permission")
			[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
			$new4 = $xml.createElement("permission")
			[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
			$new5 = $xml.createElement("permission")
			[void]$new5.set_InnerText("hudson.model.Item.Workspace:$useradd")
			$new6 = $xml.createElement("permission")
			[void]$new6.set_InnerText("hudson.model.Item.Configure:$useradd")
			$new7 = $xml.createElement("permission")
			[void]$new7.set_InnerText("hudson.model.Item.Cancel:$useradd")
			$new8 = $xml.createElement("permission")
			[void]$new8.set_InnerText("hudson.model.Item.Read:$useradd")
			$new9 = $xml.createElement("permission")
			[void]$new9.set_InnerText("hudson.model.Item.Delete:$useradd")
			$new10 = $xml.createElement("permission")
			[void]$new10.set_InnerText("hudson.model.Item.Build:$useradd")
			$new11 = $xml.createElement("permission")
			[void]$new11.set_InnerText("hudson.model.Item.Move:$useradd")
			$new12 = $xml.createElement("permission")
			[void]$new12.set_InnerText("hudson.model.Item.Discover:$useradd")
			$new13 = $xml.createElement("permission")
			[void]$new13.set_InnerText("hudson.model.Run.Delete:$useradd")
			$new14 = $xml.createElement("permission")
			[void]$new14.set_InnerText("hudson.model.Run.Replay:$useradd")
			$new15 = $xml.createElement("permission")
			[void]$new15.set_InnerText("hudson.model.Run.Update:$useradd")
			$new16 = $xml.createElement("permission")
			[void]$new16.set_InnerText("hudson.scm.SCM.Tag:$useradd")
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
			$xml.save($_.FullName)
		}
				
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Admin Role in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd in MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-mem-menu
}

function add-mem-read
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
			[void]$parent.appendChild($new)
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
			[void]$parent.appendChild($new)
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
			[void]$parent.appendChild($new)
			$xml.save($_.FullName)
		}

	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Read Role in all MEMIC Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-mem-menu
}

function add-mem-collab
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}

	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}	

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
		Write-Host "You have staged to add $useradd in MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-mem-menu
}

function add-mem-operate
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point` In\jobs\MEMIC_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}

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
		Write-Host "You have staged to add $useradd MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-mem-menu
}

function add-sre-admin
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
			$new1 = $xml.createElement("permission")
			[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
			$new2 = $xml.createElement("permission")
			[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
			$new3 = $xml.createElement("permission")
			[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
			$new4 = $xml.createElement("permission")
			[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
			$new5 = $xml.createElement("permission")
			[void]$new5.set_InnerText("hudson.model.Item.Workspace:$useradd")
			$new6 = $xml.createElement("permission")
			[void]$new6.set_InnerText("hudson.model.Item.Configure:$useradd")
			$new7 = $xml.createElement("permission")
			[void]$new7.set_InnerText("hudson.model.Item.Cancel:$useradd")
			$new8 = $xml.createElement("permission")
			[void]$new8.set_InnerText("hudson.model.Item.Read:$useradd")
			$new9 = $xml.createElement("permission")
			[void]$new9.set_InnerText("hudson.model.Item.Delete:$useradd")
			$new10 = $xml.createElement("permission")
			[void]$new10.set_InnerText("hudson.model.Item.Build:$useradd")
			$new11 = $xml.createElement("permission")
			[void]$new11.set_InnerText("hudson.model.Item.Move:$useradd")
			$new12 = $xml.createElement("permission")
			[void]$new12.set_InnerText("hudson.model.Item.Discover:$useradd")
			$new13 = $xml.createElement("permission")
			[void]$new13.set_InnerText("hudson.model.Run.Delete:$useradd")
			$new14 = $xml.createElement("permission")
			[void]$new14.set_InnerText("hudson.model.Run.Replay:$useradd")
			$new15 = $xml.createElement("permission")
			[void]$new15.set_InnerText("hudson.model.Run.Update:$useradd")
			$new16 = $xml.createElement("permission")
			[void]$new16.set_InnerText("hudson.scm.SCM.Tag:$useradd")
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
			$new1 = $xml.createElement("permission")
			[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
			$new2 = $xml.createElement("permission")
			[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
			$new3 = $xml.createElement("permission")
			[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
			$new4 = $xml.createElement("permission")
			[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
			$new5 = $xml.createElement("permission")
			[void]$new5.set_InnerText("hudson.model.Item.Workspace:$useradd")
			$new6 = $xml.createElement("permission")
			[void]$new6.set_InnerText("hudson.model.Item.Configure:$useradd")
			$new7 = $xml.createElement("permission")
			[void]$new7.set_InnerText("hudson.model.Item.Cancel:$useradd")
			$new8 = $xml.createElement("permission")
			[void]$new8.set_InnerText("hudson.model.Item.Read:$useradd")
			$new9 = $xml.createElement("permission")
			[void]$new9.set_InnerText("hudson.model.Item.Delete:$useradd")
			$new10 = $xml.createElement("permission")
			[void]$new10.set_InnerText("hudson.model.Item.Build:$useradd")
			$new11 = $xml.createElement("permission")
			[void]$new11.set_InnerText("hudson.model.Item.Move:$useradd")
			$new12 = $xml.createElement("permission")
			[void]$new12.set_InnerText("hudson.model.Item.Discover:$useradd")
			$new13 = $xml.createElement("permission")
			[void]$new13.set_InnerText("hudson.model.Run.Delete:$useradd")
			$new14 = $xml.createElement("permission")
			[void]$new14.set_InnerText("hudson.model.Run.Replay:$useradd")
			$new15 = $xml.createElement("permission")
			[void]$new15.set_InnerText("hudson.model.Run.Update:$useradd")
			$new16 = $xml.createElement("permission")
			[void]$new16.set_InnerText("hudson.scm.SCM.Tag:$useradd")
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
			$xml.save($_.FullName)
}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Update:$useradd")
			$new1 = $xml.createElement("permission")
			[void]$new1.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Delete:$useradd")
			$new2 = $xml.createElement("permission")
			[void]$new2.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomain:$useradd")
			$new3 = $xml.createElement("permission")
			[void]$new3.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.View:$useradd")
			$new4 = $xml.createElement("permission")
			[void]$new4.set_InnerText("com.cloudbees.plugins.credentials.CredentialsProvider.Create:$useradd")
			$new5 = $xml.createElement("permission")
			[void]$new5.set_InnerText("hudson.model.Item.Workspace:$useradd")
			$new6 = $xml.createElement("permission")
			[void]$new6.set_InnerText("hudson.model.Item.Configure:$useradd")
			$new7 = $xml.createElement("permission")
			[void]$new7.set_InnerText("hudson.model.Item.Cancel:$useradd")
			$new8 = $xml.createElement("permission")
			[void]$new8.set_InnerText("hudson.model.Item.Read:$useradd")
			$new9 = $xml.createElement("permission")
			[void]$new9.set_InnerText("hudson.model.Item.Delete:$useradd")
			$new10 = $xml.createElement("permission")
			[void]$new10.set_InnerText("hudson.model.Item.Build:$useradd")
			$new11 = $xml.createElement("permission")
			[void]$new11.set_InnerText("hudson.model.Item.Move:$useradd")
			$new12 = $xml.createElement("permission")
			[void]$new12.set_InnerText("hudson.model.Item.Discover:$useradd")
			$new13 = $xml.createElement("permission")
			[void]$new13.set_InnerText("hudson.model.Run.Delete:$useradd")
			$new14 = $xml.createElement("permission")
			[void]$new14.set_InnerText("hudson.model.Run.Replay:$useradd")
			$new15 = $xml.createElement("permission")
			[void]$new15.set_InnerText("hudson.model.Run.Update:$useradd")
			$new16 = $xml.createElement("permission")
			[void]$new16.set_InnerText("hudson.scm.SCM.Tag:$useradd")
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
			$xml.save($_.FullName)
		}
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Admin Role in all SwissRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all MEMIC jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd in MEMIC jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-sre-menu
}

function add-sre-read
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
			[void]$parent.appendChild($new)
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
			[void]$parent.appendChild($new)
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
			$parent = $xml.documentElement.selectSingleNode("/project/properties/hudson.security.AuthorizationMatrixProperty")
			$new = $xml.createElement("permission")
			[void]$new.set_InnerText("hudson.model.Item.Read:$useradd")
			[void]$parent.appendChild($new)
			$xml.save($_.FullName)
		}

	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Read Role in all SwissRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all SwissRE jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd SwissRE jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-sre-menu
}

function add-sre-collab
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}

	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}	

	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Collaborator Role in all SwissRE Jobs"
		$Body = "Executed by $userlog at $timelog and add $useradd in all SwissRE jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd in SwissRE jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-sre-menu
}

function add-sre-operate
{
	<# Input Variables #>	
		write-host "Please input properly!"
		$timelog = get-date -format g
		$date = get-date -format MMddyy
		$useradd = read-host [Enter the username to add]
	
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_PRD\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_STG\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}
		
	<# Command to backup config.xml in every job appended with "-MMDDYY" (e.g. config.xml-110717) #>	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			copy ($_.FullName) ($_.FullName+(get-date -format -MMddyy-hhss))
		}
		
	<# Command to update each & every config.xml with $useradd added from the content #> 	
		Get-ChildItem "E:\Program` Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs" -recurse -Filter config.xml |
		foreach-object {
			[xml]$xml = Get-Content $_.FullName
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
			$xml.save($_.FullName)
		}

	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Added $useradd as Operator Role in all SwissRE Jobs"
		$Body = "==========================================================================="
        $Body += "<h2>Executed by <b>$userlog</b> at <b>$timelog</b></h2>"
        $Body += "=========================================================================="
        $Body += "<h2>User <b>$useradd<b> has been added as <i>Operator</i> in all SwissRE jobs</h2>"
        $Body += "=========================================================================="
		$smtpServer = "normail.csc-fsg.com"
		<#$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)#>
        send-MailMessage -SmtpServer $smtpServer -To $smtpTo -From $smtpfrom -Subject $Subject -Body $Body -BodyAsHtml -Priority high 
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd SwissRE jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		
		Write-Host "You have sent email notification!"			
		Write-Host "You have staged to add $useradd SwissRE jobs"
		Write-Host "Make sure that there are no running jobs in Jenkins PRD before restarting Jenkins Service"
		pause	
			
clear	
addrole-sre-menu
}

$timelog = get-date -format g
$userlog = read-host [Enter your short name "e.g. jcanas3"]
clear
Main-Menu
clear
