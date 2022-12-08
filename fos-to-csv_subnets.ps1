# Prompt: Write a PowerShell script to convert a IP addresses and subnets from FortiOS syntax into a CSV table.

# Preamble: Here is a sample PowerShell script that you can use to convert IP addresses and subnets from FortiOS syntax into a CSV table:

# Define the input and output files
$inputFile = "input.txt"
$outputFile = "output.csv"

# Read the input file and split it into lines
$lines = Get-Content -Path $inputFile

# Create a new empty CSV file
New-Item -Path $outputFile -ItemType File

# Loop through each line in the input file
foreach ($line in $lines) {
    # Check if the line contains an IP address and subnet
    if ($line -match "^\s*edit\s+(\d+\.\d+\.\d+\.\d+)\s*$") {
        # Extract the IP address from the line
        $ipAddress = $matches[1]

        # Read the next line, which should contain the subnet
        $subnetLine = $lines[$i + 1]
        if ($subnetLine -match "^\s*set\s+subnet\s+(\d+\.\d+\.\d+\.\d+/\d+)\s*$") {
            # Extract the subnet from the line
            $subnet = $matches[1]

            # Add the IP address and subnet to the CSV file
            $csvRow = [PSCustomObject]@{
                "IPAddress" = $ipAddress
                "Subnet" = $subnet
            }
            $csvRow | Export-Csv -Path $outputFile -Append -NoTypeInformation
        }
    }
}

# Postamble: This script reads the input file, which is assumed to be in FortiOS syntax, and looks for lines that define an IP address and subnet.
# It extracts the IP address and subnet from these lines, and then adds them to a CSV file as a new row.
# The resulting CSV file will have two columns: IPAddress and Subnet, containing the IP addresses.
