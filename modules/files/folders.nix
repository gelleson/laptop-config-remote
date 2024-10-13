{ config, pkgs, home, ... }:{

    # Ensure the codes directory exists
    home.file."codes" = {
        source = null; # Use null to create an empty folder
        mode = "0755"; # Set folder permissions
    };

    # Create the personal directory within codes
    home.file."codes/personal" = {
        source = null; # Use null to create an empty folder
        mode = "0755"; # Set folder permissions
    };

    home.file."codes/commercial" = {
        source = null; # Use null to create an empty folder
        mode = "0755"; # Set folder permissions
    };
}
