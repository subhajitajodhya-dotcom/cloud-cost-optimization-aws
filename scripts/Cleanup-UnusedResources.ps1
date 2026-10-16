# Finds unattached EBS volumes and snapshots older than N days.
# By default it only REPORTS. Add -Delete to actually remove them.
#
#   .\Cleanup-UnusedResources.ps1              (report only)
#   .\Cleanup-UnusedResources.ps1 -Delete      (delete what it found)
param(
    [int]$SnapshotAgeDays = 30,
    [switch]$Delete
)

$cutoff = (Get-Date).AddDays(-$SnapshotAgeDays).ToString("yyyy-MM-dd")

# Unattached volumes
$volumes = aws ec2 describe-volumes `
    --filters "Name=status,Values=available" `
    --query "Volumes[].VolumeId" --output text
$volumes = $volumes -split "\s+" | Where-Object { $_ }

Write-Output "Unattached EBS volumes: $($volumes.Count)"
$volumes | ForEach-Object { Write-Output "  $_" }

# Old snapshots owned by this account
$snapshots = aws ec2 describe-snapshots --owner-ids self `
    --query "Snapshots[?StartTime<='$cutoff'].SnapshotId" --output text
$snapshots = $snapshots -split "\s+" | Where-Object { $_ }

Write-Output "Snapshots older than $SnapshotAgeDays days: $($snapshots.Count)"
$snapshots | ForEach-Object { Write-Output "  $_" }

if ($Delete) {
    foreach ($v in $volumes)   { aws ec2 delete-volume --volume-id $v;     Write-Output "Deleted volume $v" }
    foreach ($s in $snapshots) { aws ec2 delete-snapshot --snapshot-id $s; Write-Output "Deleted snapshot $s" }
} else {
    Write-Output "Report only. Re-run with -Delete to remove these."
}
