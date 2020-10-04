```
                   ,     ,  ._  ,
                 _.MMmm.mMm_Mm.MMm_:mMMmmm.._  .
            _ .-mmMMMMMMMMMMMMm:MMm:MMMMMMMMMm._
             `-.mm.MMMMMMM:MMMMMMMmmMMMMMMMMMmm._
          _.mMMMMMmMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"~.
           .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm._
          _.MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm._
       ..mMMMMMMMMMMMMMMMMF"""`:MMMMMMMMMMMMMMMMMMMMmmm.
      _.mmMMMMMMMMMMMMM'    /^  )MMMMMMMMMMMMMMMMMMMMm.
       _.MMMMMMMMMMMM/       JMMMMMMMMMMMMMMMMMMMMMMMMm_
   .mmMMMMMMMMMMMMME/       J,  MMMMMMMMMMMMMMMMMMMMMMMm,
  _.-' _.mMMMMMMMMM/        |:  '::M:MMMMMMMMMMMMMMMM""`
   _,MMMmMMMMMMMMMJ         |_   `:MmmMMMMMMMMMMMMMMMmm.
     _.-'MMMMMMMMF         /M.    .MMmMMMMMMMMMMMMMMMMMM.
    .mmMMMMMMMMMMJ        /MMn:.   `MMMMMMMMMMMMMMMMMMMm.
       .MMMMMMMMJ        /M'        `:::'MMMMMMMMMMMMMMM:
    ,MMMmMMMMMMF         |:   _.._    '   MMMMMMMMMMMMmm.
   ,ME:MMMMMMMM|         J               7_MMMMMMMMM:Mm_
   !M:MmmMMMMMM|        /     _____     _JMMMMMMMMMm:MMm.
   '':mMMMMMMMMJ        |    `"==="`    /dMMMMMMMMMMM:'Mm.
    ':MMM:MMMMF        J\              /MMMMMM:MMMMMMm: `
   .M:MMM:MMMM|        |E`.   .   .  ,'MMMMMMM:MMMMMMMm
     .Mm:mMMMMJ        |M| `.      .' |MMMMMMm:.MMMMM.
    .Mm:mMMMM/         |M|   `----':: |MMMMMMMmm`MMMMMm.
      !:mMMM/          /M|      ::::. |MMMMMMMMMMM``mMm.
        !MMJ          |MM|      .:::. |MMMMMMMMMMMMM.._
        MMF           /M/       ::::'  \MMMMMMMMMMMMMMm,
       .mM|          /MMm.       '     .`".MMMMMMMMMMMMm.
        !!J         / b:.:..     ,  ,   .. M.".MMMMMMMMm.
         F         .:`.m,  ..           ..`M.   `"".MMMmm.
         |          .`  b.   ..         ..  `M        `.M!
         |         .:   `b    ..        ..   M           \
         `       ..:     M,   ..         ..  M.           |
          |     :::,     `M,   ..        ..  `M           \
          |      .'       `M    ..       ..   M.           |
          `                M.    ..      ..   `M    ,      \
           |               .M.    ..     ..    M   Y        |
           `              .dMb.    ..   ..     M.  |        |
            \            dMMMMMMb.  ':. ::     M.  |        \
             Y        .dMMMMMMMMMMMb.::_::___.dMMb |         |
             |      .dMMMMMMMMMMMMMMMMM::MMMMMMMMMb/         |
             :.....dMMMMMMMMMMMMMMMMMMM::MMMMMMMMMMM\        |
              MMMMMMMMMMMMMMMMMMMMMMMMp""qMMMMMMMMMM \       `
              `MMMMMMMMMMMMMMMMMMMMMMM:QD:MMMMMMMMMM  \       |
               `MMMMMMMMMMMMMMMMMMMMMMb.:dMMMMMMMMMP  |       |
                `MMMMMMMMMMMMMMMMMMM::::::::MMMMMMF   |       `
                 MMMMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM    |        `
                 `MMMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM    :         |
                  MMMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM     \        |
                  `MMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM      |       `
                   MMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM      `        .
                   `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                   .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                   dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       `        |
                 .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM        .       |
                .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM        |       |

Linux Profile by Cosckoya
```
# Requires the following debian / ubuntu packages

```
git
make
curl
python3
python3-distutils
```

Help: run `make help`

<!-- START makefile-doc -->
```
$ make help 

Klaatu Barata Nitko!

addons                         Install Addons: tig, asdf, cheat, docker-compose, asdf +More
all                            Install Profile, IaC, Cloud and terminal addons
ansible                        Install Pip3+Ansible. Set version with `make ansible ANSIBLE_VERSION="2.9.10"` (default version: 2.9.10)
asdf                           Install asdf
aws                            Install Amazon AWS-Cli v2 (aws)
azure                          Install Azure Cli (az)
bash                           Install Bash profile
cheat                          Install cheat
cloud                          Install AWS-Cli v2, Azure Cli and Google SDK
dependencies                   Install Linux package dependencies
docker-compose                 Install docker-compose (default version: latest)
git-secret                     Install git-secret
google                         Install Google SDK (glcoud)
hadolint                       Install Hadolint
helm                           Install Helm. Set version with `make helm HELM_VERSION="v3.2.4"` (default version: v3.2.4)
help                           Shows this makefile help
iac                            Install Pip3+Ansible, Terraform and Kubernetes tools
kind                           Install Kind (Kubernetes on docker)
krew                           Install Krew: Kubectl plugin manager
kubectl                        Install Kubectl. Set version with `make kubectl KUBECTL_VERSION="v1.17.3"` (default version: v1.17.3)
kubectx                        Install Kubectx and Kubens
kubernetes                     Install Kubernetes tools: Kubectl, Helm, Krew, Kind and Kubectl
minikube                       Install Minikube
minishift                      Install Minishift. Set version with `make minishift MINISHIFT_VERSION="1.34.2"` (default version: 1.34.2)
minis                          Install Minikube and Minishift local kubernetes clusters
neovim                         Install Vim/Neovim profile and vimplug plugins
pip                            Install Python Pip3
pre-commit                     Install Pre-Commit
profile                        Install ZSH, TMUX and Vim/Neovim plugins and profiles
terraform                      Install Terraform. Set version with `make terraform TERRAFORM_VERSION="0.12.28"` (default version: 0.12.28)
tfdocs                         Install / Updated Terraform-docs
tflint                         Install / Updrade TFLint util
tfsec                          Install / Updated tfsec: Terraform Security Compliance
tftools                        Install Terraform local tools: tflint, terraform-docs and
tig                            Install Tig
tmux                           Install TMUX profile
zsh                            Sets ZSH as default Shell, and install ZSH profile and zplug with plugins 
```
<!-- END makefile-doc -->
