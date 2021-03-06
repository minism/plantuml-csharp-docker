Source code for https://hub.docker.com/repository/docker/minism/plantuml-csharp

Simple image to facilitate rendering UML images from C# source code.

The entrypoint script takes two arguments, the path to the input directory and the path to the output directory, both of which are relative to the directory mounted on the `/code` volume.

Example usage on a Unity repository:

    docker run --rm -v "$(pwd):/code" minism/plantuml-csharp Assets/Scripts Diagrams
    
Extra arguments after input and output directories are forwarded to the puml-gen command [documented here](https://github.com/pierre3/PlantUmlClassDiagramGenerator#usage). For example:

    docker run --rm -v "$(pwd):/code" minism/plantuml-csharp Assets/Scripts Diagrams -public -createAssociation -allInOne

Technologies used:

- [PlantUML](https://plantuml.com/)
- [PlantUmlClassDiagramGenerator](https://github.com/pierre3/PlantUmlClassDiagramGenerator)
- [GraphViz](https://www.graphviz.org/)
