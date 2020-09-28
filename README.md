# Transform docker-compose format .yml files to openshift format .yml files

The input files are those placed in the folder `docker-compose-yml-files`.
They are transformed to openshift format .yml files, and then placed in the folder `openshift-yml-files`.


## Steps

1. Place the source files in the destination directory of the openshift format .yaml files.
   
2. Modify the value of the version attribute (from 2.1 to 2) in the following files:
   1. /base/docker-compose-base.yaml
   2. /base/peer-base.yaml
   3. docker-compose-cli.yaml
   
3. Move the peer-base.yaml file in the same directory as the docker-compose-cli.yaml file.

4. Run this command
   ```
$ kompose --provider openshift --file `docker_compose_file.yaml` convert
```
Example: ```
$ kompose --provider openshift --file docker-compose-cli.yaml convert
```
This command will generate multiple .yaml files in openshift format.

5. Move the openshift format generated files in the folder  `openshift-yml-files`.

## Sources

https://kubernetes.io/fr/docs/tasks/configure-pod-container/translate-compose-kubernetes/