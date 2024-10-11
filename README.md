git clone https://github.com/Minaeff1q/business_role

cd project/terraform

terraform init
terraform apply --auto-approve

после того как машина развернётся назначаем ей публичный ip адресс
копируем скрипты на удаленный сервер
scp ../scripts/*.sh ubuntu@<ip-публичный>: ~/
выполням shh подключение
ssh ubuntu@<ip-публичный>

sudo bash setup_awx.sh
sudo bash setup_terraform.sh

по оканчанию установки идем по публичному ip в браузер
