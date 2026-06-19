# Define the bit value for per-user services in the ServiceType property of a service object
$flag = 64

# Define an empty array to store the resulting services that match the criteria
$serviceList = @()

# Get all services on the computer and store them in the variable
$services = Get-Service

# Loop through each service in the array of services.
foreach ( $service in $services ) {
  # For each specific service, check if the service type property includes the 64 bit using the bitwise AND operator (-band).
  # If the result equals the flag value, then the service is a per-user service.
  if ( ( $service.ServiceType -band $flag ) -eq $flag ) {
    # When a per-user service is found, then add that service object to the results array.
    $serviceList += $service
  }
}

# Display the results array, sorted by display name, in a table format with the specified properties.
$serviceList | Sort-Object DisplayName | Format-Table DisplayName, Name, StartType, ServiceType