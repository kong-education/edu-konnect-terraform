#!/bin/bash

cd data_plane
terraform destroy -auto-approve

cd ../control_plane
terraform destroy -auto-approve