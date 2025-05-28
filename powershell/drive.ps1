Get-PhysicalDisk | ForEach-Object {
    $disk = $_
    Get-Partition -DiskNumber $disk.DeviceID | ForEach-Object {
        Get-Volume -Partition $_ | ForEach-Object {
            [PSCustomObject]@{
                DriveLetter = $_.DriveLetter
                FriendlyName = $disk.FriendlyName
                Manufacturer = $disk.Manufacturer
                Model = $disk.Model
                SerialNumber = $disk.SerialNumber
                Size = $disk.Size
            }
        }
    }
} | Format-Table DriveLetter, FriendlyName, Manufacturer, Model, SerialNumber, @{Name="Size (GB)"; Expression={$_.Size / 1GB -as [int]}}