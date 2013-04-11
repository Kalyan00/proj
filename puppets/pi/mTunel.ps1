$TunnelPort = 18281
$ListenerPort = 18282
$SshStr = ""+ @(
		"root@kalyan00.homeip.net"       # Host
	,	" -p 10222"                      # Port 
	,	" -R 3369:msk-0069:3389"         # RDP msk-0069 Kalyan00
	,	" -R 1101:msk-1101:3389"         # RDP msk-1101 DVolodko
	,	" -R 3346:msk-0946:3389"         # RDP msk-0946 0946
	,	" -R 3368:msk-0068:3389"         # RDP msk-0068 Overlord
	,	" -R 3318:msk-1118:3389"         # RDP msk-1118 EEremina
	,	" -D 5192"                       # Socks 5
	,	" -L 5191:127.0.0.1:5190"        # WC: Squid http_port 5190
)
$logfile = 'c:\temp\mTunnel.log'
$debug=$True
$debug=$false

function logInner($text, $WriteFile)
{
	if($WriteFile -or $debug)
	{
		if((test-path($logfile)) -and ((dir $logfile).Length -gt 1000000) )
		{
			$files=10
			$appendBefor=""
			while($files -gt -1)
			{
				$append = ""
				if($files -gt 0)
				{
					$append = ".$files"
				}

				#Write-Host("check ($logfile$append) ($logfile$appendBefor)")
				if(! [string]::IsNullOrEmpty($appendBefor)) 
				{ 
					#Write-Host("asdfasdf")
					if(test-path("$logfile$appendBefor")) 
					{
						del "$logfile$appendBefor"
					}
					if(test-path("$logfile$append"))
					{
						move "$logfile$append" "$logfile$appendBefor"
						#Write-Host("move ($logfile$append) ($logfile$appendBefor)")
					}
				}

				$appendBefor=$append
				$files = $files-1
			}
		}

		$text >> $logfile
	}
	Write-Host($text)
}
function log($text, $WriteFile)
{
	logInner( "")
	logInner -text ("["+[DateTime]::Now+"]") -WriteFile $WriteFile
	logInner -text $text -WriteFile $WriteFile
}
log("START")

function GetListnerJob()
{
	return start-job  { param($ListenerPort) 
		$okSr ="mTunnel works!"
		$port = $ListenerPort

		$endpoint = new-object System.Net.IPEndPoint([system.net.ipaddress]::any, $port)
		$listener = new-object System.Net.Sockets.TcpListener $endpoint
		$listener.start()
		$sendBytes = [System.Text.Encoding]::UTF8.GetBytes($okSr)
		$listener.AcceptTcpClient().GetStream().Write($sendBytes, 0, $sendBytes.Length)
		$listener.stop() 
		#write-progress "OK" -status "OK" -PercentComplete 100
	} -ArgumentList $ListenerPort
}

function testTunnels( $seconds)
{

	$jobscript = { param ($TunnelPort,$ListenerPort)
		write-progress "OK" -status "starting $TunnelPort,$ListenerPort" -PercentComplete 0


		function GetListnerJob()
		{
			write-progress "OK" -status "GetListnerJob" -PercentComplete 18
			return start-job  { param($ListenerPort) 
				$okSr ="mTunnel works!"
				$port = $ListenerPort

				$endpoint = new-object System.Net.IPEndPoint([system.net.ipaddress]::any, $port)
				$listener = new-object System.Net.Sockets.TcpListener $endpoint
				$listener.start()
				$sendBytes = [System.Text.Encoding]::UTF8.GetBytes($okSr)
				$listener.AcceptTcpClient().GetStream().Write($sendBytes, 0, $sendBytes.Length)
				$listener.stop() 
				#write-progress "OK" -status "OK" -PercentComplete 100
			} -ArgumentList $ListenerPort
		}

		function Connect($port)
		{
			write-progress "OK" -status "Connect $port START" -PercentComplete 10
			try
			{
				$client = new-object System.Net.Sockets.TcpClient("127.0.0.1", $port)	
			}
			catch
			{
				#Write-Host
				write-progress "OK" -status "Connect $port return false" -PercentComplete 1
				return $False
			}

			$stream = $client.GetStream()
			try
			{
				if($stream.ReadByte() -lt 0)
				{
					return $False
				}
			}	
			catch
			{
				#Write-Host
				write-progress "OK" -status "Connect $port Read Failed return false!" -PercentComplete 2
				return $False
			}

			$stream.Close();         
			$client.Close(); 
			#Write-Host
			write-progress "OK" -status "Connect $port return true" -PercentComplete 3
			return $True   
		}
		function WaitListnerJob($job, $seconds)
		{

			while ($job.JobStateInfo.State -eq "Running")
			{
				sleep 1
				$seconds = $seconds - 1	

				#Write-Host
				write-progress "OK" -status $seconds -PercentComplete 4 
				if($seconds -lt 0) 
				{
					break;
				}
			}
			#Write-Host
			write-progress "OK" -status ("WaitListnerJob: " + $job.JobStateInfo.State + " "+ $Message) -PercentComplete 5
		}
		function TestConnection()
		{
			
			if(Connect $ListenerPort)
			{
				return $False
			}

			$job = GetListnerJob
		#$job.ChildJobs[0].progress[0].percentComplete
			sleep 1
			if($job.JobStateInfo.State -eq "Completed")
			{
				#Write-Host
				write-progress "OK" -status "port blocked" -PercentComplete 6
		#$job.ChildJobs[0].progress[0].percentComplete
				return $False
			}

			if(Connect $TunnelPort)
			{
				WaitListnerJob $job  12
			}
			else
			{	
				#Write-Host
				write-progress "OK" -status $job.JobStateInfo.State  -PercentComplete 7
			}

			if($job.JobStateInfo.State -eq "Running")
			{
				$null = Connect $ListenerPort
		#$job.ChildJobs[0].progress[0].percentComplete
				return $False
			}

			if($job.JobStateInfo.State -eq "Completed")
			{
		#$job.ChildJobs[0].progress[0].percentComplete
				return $True
			}
		#$job.ChildJobs[0].progress[0].percentComplete
			return $False
		}
		$i = TestConnection
		if($i)
		{write-progress "OK" -status "OK" -PercentComplete 100}
		else
		{write-progress "OK" -status "--" -PercentComplete 99}
		

} 
	#$jobscript.Invoke($TunnelPort,$ListenerPort)
	$job = start-job $jobscript -ArgumentList ($TunnelPort,$ListenerPort)
	
	function WaitListnerJob($job, $seconds)
	{
		log("WaitListnerJob seconds=$seconds")
		while ($job.JobStateInfo.State -eq "Running")
		{
			sleep 1
			$seconds = $seconds - 1	

			if($seconds -lt 0) 
			{
				break;
			}
		}
		log("WaitListnerJob (seconds=$seconds): " + $job.JobStateInfo.State + " "+ $Message)
	}
	WaitListnerJob $job $seconds
	return $job.ChildJobs[0].progress
}


function CheckTunnel
{
	$OK = $False
	$jobProgress = testTunnels 15
	$log = $jobProgress |foreach { if($_.percentComplete -eq 100){$OK = $True}; (""+$_.percentComplete +" - " + $_.statusDescription)}
	log($log)
	return $OK
}

$SshStr = $SshStr  +  @(
		" -L $($TunnelPort):127.0.0.1:$ListenerPort"     # с локального1 до сервака
	,	" -R $($ListenerPort):127.0.0.1:$ListenerPort"   # с сервака на локальный2
	
	,	" -C ./scripts/ssh-util $ListenerPort"           # выполняем спец.скрипт для убиения подвисших sshd, залочивших порт
)

log("ssh $SshStr")

$pssh = Start-Process ssh -ArgumentList $SshStr -NoNewWindow -PassThru 2>>$logfile
sleep 10

$loggerCounter = 0
while ( CheckTunnel)
{
	log -text ("CheckTunnel:OK pssh.HasExited:"+ $pssh.HasExited) -WriteFile ($debug -or ($loggerCounter -eq 0) -or $pssh.HasExited)
	if($loggerCounter -eq 0) { $loggerCounter = 60 } ; 	$loggerCounter = $loggerCounter - 1
	
	sleep 60
}

log -text ("CheckTunnel:false pssh.HasExited:"+ $pssh.HasExited) -WriteFile $true
if(!$pssh.HasExited)
{
	log("stopping $pssh")
	stop-process $pssh.Id
	sleep 1
}
log("Exit")

