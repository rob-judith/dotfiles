function omega-sequence --description 'Update and shutdown'
    sudo snap refresh && sudo apt update && apt list --upgradeable && sudo apt upgrade -y && shutdown now
end
