function Main-Menu 
{
    do
    {
        Write-Host "MAIN MENU"
		Write-Host "1. Remove User Account `n2. ADD User Account `n3. Exit "
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!"  } 
		Switch ($input) {
            "1" {
				clear
				rem-usr
				}
            "2" {
				clear
				add-usr
				}
            "3" {
				clear
				Exit
				}
        }
    }
    until (1..3 -contains $input) 
}

function rem-usr 
{
    do
    {
        Write-Host "REMOVE Utility MENU"
		Write-Host "1. ALL Memic Jobs `n2. SwissRE Jobs `n3. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {
				clear
				rem-mem-jobs
				}
            "2" {
				clear
				rem-sre-jobs
				}
            "3" {
				clear
				Main-Menu
				}
        }
    }
    until (1..3 -contains $input) 
}

function add-usr 
{
    do
    {
        Write-Host "ADD Utility MENU"
		Write-Host "1. All Memic Jobs `n2. All SwissRE Jobs `n3. Return to Main Menu"
        $input = read-host [Enter Selection]
        Switch ($input) {
            "1" {add-mem-jobs}
            "2" {add-sre-jobs}
            "3" {Main-Menu}
        }
    }
    until (1..3 -contains $input) 
}

function rem-mem-jobs
{
		write-host "Please input properly!"
	<# Input Variables #>
		$time = get-date -format g
		$userlog = read-host [Enter your short name "e.g. jcanas3"]
		$datelog = read-host [Enter the date "e.g. mm-dd-yy"]
		$userrem = read-host [Enter username to remove]
		$cdmemprd = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_PRD\jobs\"
		$cdmemstg = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_STG\jobs\"
		$cdmemuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\MEMIC\jobs\Point In\jobs\MEMIC_UAT\jobs\"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
		
	<# Script to remove $userrem from MEMPRD jobs config.xml and update the Jenkins UI #>
	<#Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemprd\MEMPRD-Backout-PRDPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memprdconfig1.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memprdconfig1.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDPRE/config.xml
				
		Get-Content $cdmemprd\MEMPRD-Backout-PRDSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memprdconfig2.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memprdconfig2.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Backout-PRDSRV/config.xml
		
		Get-Content $cdmemprd\MEMPRD-Deploy-PRDPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memprd3config3.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memprdconfig3.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml
		
		Get-Content $cdmemprd\MEMPRD-Deploy-PRDSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memprd4config4.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memprdconfig4.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDPRE/config.xml
		
		Get-Content $cdmemprd\MEMPRD-Deploy-PRDSQL\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memprd5config5.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memprdconfig5.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_PRD/job/MEMPRD-Deploy-PRDSQL/config.xml
			
		Write-Host "You have remove $userrem in MEMIC PRD jobs"
		pause
	
	<# Script to remove $userrem from MEMSTG jobs config.xml and update the Jenkins UI #>
	<# Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemstg\MEMSTG-Backout-STGPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memstgconfig1.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memstgconfig1.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Backout-STGPRE/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Backout-STGSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memstgconfig2.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memstgconfig2.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Backout-STGSRV/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Deploy-STGPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memstgconfig3.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memstgconfig3.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Deploy-STGPRE/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Deploy-STGSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memstgconfig4.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memstgconfig4.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Deploy-STGPRE/config.xml
		
		Get-Content $cdmemstg\MEMSTG-Deploy-STGSQL\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memstgconfig5.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memstgconfig5.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_STG/job/MEMSTG-Deploy-STGSQL/config.xml
			
	
		Write-Host "You have remove $userrem in MEMIC STG jobs"
		pause
	
	<# Script to remove $userrem from MEMUAT jobs config.xml and update the Jenkins UI #>
	<# Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemuat\MEMUAT-Backout-UATPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memuatconfig1.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memuatconfig1.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Backout-UATPRE/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Backout-UATSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memuatconfig2.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memuatconfig2.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Backout-UATSRV/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Deploy-UATPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memuatconfig3.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memuatconfig3.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Deploy-UATPRE/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Deploy-UATSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memuatconfig4.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memuatconfig4.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Deploy-UATPRE/config.xml
		
		Get-Content $cdmemuat\MEMUAT-Deploy-UATSQL\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\memuatconfig5.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\memuatconfig5.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/MEMIC/job/Point%20In/job/MEMIC_UAT/job/MEMUAT-Deploy-UATSQL/config.xml
			
		Write-Host "You have remove $userrem in MEMIC UAT jobs"
				
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Remove $userrem in all MEMIC Jobs"
		$Body = "Executed by $userlog and remove $userrem in PRD, UAT & STG jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
		pause
		rem-usr
}

function rem-sre-jobs
{
		write-host "Please input properly!"
	<# Input Variables #>
		$time = get-date -format g
		$userlog = read-host [Enter your short name "e.g. jcanas3"]
		$datelog = read-host [Enter the date "e.g. mm-dd-yy"]
		$userrem = read-host [Enter username to remove]
		$cdsreuat = "C:\Program Files\Jenkins\jobs\Deploy\jobs\SwissRE\jobs\PointInJ\jobs\SwissRE_UAT\jobs\"
		$wget = "C:\Program Files (x86)\GnuWin32\bin\wget.exe"
		$adminuser = "jcanas3"
		$pswd = "Welcome@123"
	
	<# Script to remove $userrem from config.xml and update the Jenkins UI #>
    <# Get-Content of config.xml remove $userremo and save copy to C:\Temp\jnkbak the updates UI without restarting the Jenkins Service#>
		Get-Content $cdmemic\SREUAT-Deploy-PRDPRE\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\sreuatconfig1.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\config3.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
	
		Get-Content $cdmemic\SREUAT-Deploy-PRDSRV\config.xml -notmatch "$userrem" | Out-File "C:\Temp\jnkbak\sreuatconfig2.xml" 
		cmd.exe /C $wget --auth-no-challenge --user=$adminuser --password=$pswd --post-file="C:\Temp\jnkbak\config4.xml" --no-check-certificate https://gbshosting-prd.jenkins.fsg.amer.csc.com/job/Deploy/job/SwissRE/job/PointInJ/job/SwissRE_UAT/job/SREUAT-Deploy-UATPRE/config.xml
	
		write-host "You have remove $userrem in SwissRE UAT jobs"
		pause
	
	<# Email Variables & Script#>
		$smtpFrom = "jcanas3@csc.com"
		$smtpTo = "jcanas3@csc.com"
		$emailCc = "jcanas3@csc.com"
		$Subject = "Remove $userrem in all SwissRE Jobs"
		$Body = "Executed by $userlog and remove $userrem in UAT jobs `r`n"	
		$smtpServer = "normail.csc-fsg.com"
		$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
		$smtp.Send($smtpFrom,$smtpTo,$Subject,$Body)
		
		Write-Host "You have sent email notification!"
		pause
		rem-usr
}

function add-mem-jobs
{
    do
    {
        Write-Host "User ADD Management MENU"
		Write-Host "1. ADMIN User `n2. Read Only User `n3. Collaborator User`n4. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {
				clear
				add-mem-admin
				}
            "2" {
				clear
				add-mem-read
				}
            "3" {
				clear
				add-mem-collab
				}
			"4" {
				clear
				add-usr
				}
        }
    }
    until (1..4 -contains $input) 
}

function add-sre-jobs 
{
    do
    {
        Write-Host "User ADD Management MENU"
		Write-Host "1. ADMIN User `n2. Read Only User `n3. Collaborator User`n4. Return to Main Menu"
        $input = read-host [Enter Selection]
			IF([string]::IsNullOrWhiteSpace($input)) {            
			Write-Host "Invalid Blank Input!!!"            
			} else {            
			Write-Host "Invalid Input!!!" }
			
		Switch ($input) {
            "1" {
				clear
				add-sre-admin
				}
            "2" {
				clear
				add-sre-read
				}
            "3" {
				clear
				add-sre-collab
				}
			"4" {
				clear
				add-usr
				}
        }
    }
    until (1..4 -contains $input) 
}

function add-mem-admin
{
}

function add-mem-read
{
}

function add-mem-collab
{
}

function add-sre-admin
{
}

function add-sre-read
{
}

function add-sre-collab
{
}


Main-Menu
clear
