#!/bin/bash
echo ${{ github.ref_name }}-${{ github.run_number }}
docker login -u ${{ secrets.DOCKER_HUB_USERNAME }} -p ${{ secrets.DOCKER_HUB_PASS }}
docker pull ${{ secrets.DOCKER_HUB_USERNAME }}/${{ vars.PROJECT_NAME }}:${{ github.ref_name }}-${{ github.run_number }}
docker stop $(docker ps -aq)
docker run -d -p 5000:5000 ${{ secrets.DOCKER_HUB_USERNAME }}/${{ vars.PROJECT_NAME }}:${{ github.ref_name }}-${{ github.run_number }}