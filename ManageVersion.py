import toml

filename = "wally.toml"
version_key = "version"
container = "package"

def addVersion(version_string):
    # Split the version string into parts
    parts = version_string.split(".")

    # Convert the last part to an integer and increment it
    last_part = int(parts[-1])
    new_last_part = last_part + 1

    # Update the last part in the list of parts
    parts[-1] = str(new_last_part)

    # Join the parts back into a string
    return ".".join(parts)

# Load the TOML file
with open(filename, "r") as f:
    data = toml.load(f)

# Increment the version
if version_key in data[container]:
    currentVersion = data[container][version_key]
    data[container][version_key] = addVersion(currentVersion)

# Save the updated TOML file
with open(filename, "w") as f:
    toml.dump(data, f)