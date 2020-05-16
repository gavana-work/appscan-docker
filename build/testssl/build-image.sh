###########
#CLEANUP
###########

# echo
# echo
# echo "[removing previous image build]"
# echo
# 	docker image rm $(docker image ls | grep testssl | awk '{print $3}') --force

###########
#BUILD
###########

echo
echo
echo "[building new image]"
echo
	docker build -t testssl .