$procname="TiWorker"

$finished = 0

while ($finished -lt 3) {

  Start-Sleep 30
  Write-Output "Checking for $procname ($finished)"
  $output = "$(get-process -erroraction silentlycontinue $procname)"
  if ( $output -eq "") {
    $finished = $finished + 1
  } else {
    $finished = 0
  }

}

