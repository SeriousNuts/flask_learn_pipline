#!/bin/bash

install -m 600 -D /dev/null ~/.ssh/id_rsa
echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
ssh-keyscan -H ${{ secrets.SSH_HOST }} > ~/.ssh/known_hosts
docker login -u ${{ secrets.DOCKER_HUB_USERNAME }} -p ${{ secrets.DOCKER_HUB_PASS }}
docker pull ${{ secrets.DOCKER_HUB_USERNAME }}/${{ vars.PROJECT_NAME }}:${{ github.ref_name }}-${{ github.run_number }}
docker stop $(docker ps -aq)
docker system prune || true
docker run -d -p 5000:5000 ${{ secrets.DOCKER_HUB_USERNAME }}/${{ vars.PROJECT_NAME }}:${{ github.ref_name }}-${{ github.run_number }}