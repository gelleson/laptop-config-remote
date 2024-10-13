{ config, pkgs, home, ... }:{

    # Create the personal directory within codes
    home.file."codes/personal/README.md".text = ''
    # Personal Projects Directory

    This directory contains personal coding projects created for self-learning and experimentation. The projects here are aimed at enhancing my programming skills and exploring new technologies.

    ## Purpose

    The personal projects include various coding exercises, small applications, and experiments. They serve as a playground for trying out new ideas, learning different programming languages, and improving coding practices.


    Feel free to explore and learn from these projects!
    '';

    home.file."codes/personal/oss/README.md".text = ''
    # Open Source Software Projects

    This directory contains my contributions to open source software (OSS) projects. These projects reflect my commitment to the open-source community and my desire to collaborate with others on meaningful software development.

    ## Purpose

    The projects in this directory are designed to contribute to the open-source ecosystem. They may include standalone applications, libraries, or contributions to existing open-source projects. My goal is to enhance the usability, performance, and functionality of software through collaborative development.
    '';

    home.file."codes/personal/pets/README.md".text = ''
    # Pet Projects

    This directory contains my personal pet projects, which are small-scale applications and experiments that allow me to explore new ideas and technologies in a relaxed and creative environment.

    ## Purpose

    The projects in this directory serve as a platform for learning, experimentation, and fun. They often focus on new programming languages, frameworks, or concepts that I want to explore outside of formal work projects. These projects help me improve my skills and discover innovative solutions to various problems.

    '';

    home.file."codes/commercial/README.md".text = ''
    # Commercial Projects Directory

    This directory contains coding projects developed for commercial purposes, including client work and freelance projects. These projects showcase my professional software development skills.

    ## Purpose

    The commercial projects are created to meet client requirements and deliver functional software solutions. They reflect my experience in working with various technologies and managing software development processes.

    These projects illustrate my ability to deliver high-quality software solutions for clients.
    '';
}
