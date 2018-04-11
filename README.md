# ZSC
Zeusshield (ZSC) system: AI&P2P Insurance Market Platform [(ZSC Wiki)](https://github.com/zeus-shield/zsc/wiki), [(ZSC APIs)](https://github.com/zeus-shield/zsc/wiki#zscapireference) 

Official implementation for the solidity-based core part of the ZSC system, as well as the js-based web-client and js/php based web-adm.


## Project structure
```bash
|-- Database:  
    |-- Core part of zsc system
    |-- Solidity based implementation
|-- Token:     
    |-- zsc token contract
    |-- Based on ERC20 protocol
|-- WebClient
    |-- web3.js and javascript based implementation
    |-- Compatible with Metamask 
|-- WebAdm
    |-- web3.js, javascript and php based implementation
    |-- Compatible with Metamask 
```

## Contract inheritance
```bash
|-- owned
    |-- delegated 
        |-- log_recorder
        |-- objct 
            |-- pos_block
            |-- pos_block_pool, pos_staker_group
                |-- pos_base
            |-- adm_base
            |-- app_proxy            
            |-- db_database
            |-- db_idmanager
            |-- db_node 
                |-- wallet_base
                    |-- wallet_eth
                    |-- wallet_erc20
                |-- simulator_base
                |-- db_entity 
                    |-- db_user
                        |-- db_receiver
                        |-- db_provider
                        |-- db_staker
                |-- db_item
                |-- db_template
                |-- db_agreement
            |-- factory_base
            |-- control_base, control_info
                |-- control_apis
```

## WebServer inheritance
```bash
|-- zsc_base (php)
    |-- zsc_system_modules (php)
        |-- zsc_html_modules (php)
|-- zsc_user_management (js)
```

## WebClient inheritance
```bash
|-- zsc_html (js)
|-- zsc_user (js)
|-- zsc_element (js)
```

## .sol update log
```bash
2017.09.05: add multisigtoken.sol, multisigwallet.sol and token.sol
2017.10.28: add the initial version of zscDatabase.sol
2017.12.18: add five files: plat_math.sol v0.01; plat_string.sol v0.01; plat_vector3d.sol v0.01; db_entity.sol v0.01; db_agreement.sol v0.01
2018.02.09: add three new files: db_receiver.sol v0.03; db_database.sol v0.02; test_basic_funcs.js 0.01
2018.02.10: add one new file: db_provider.sol 0.02
2018.02.10: add one new file: db_item.sol 0.01
2018.02.11: add three new file: object.sol 0.01; db_template.sol 0.01; db_idmanager.sol 0.01
2018.02.12: add a new file: db_node.sol 0.01
2018.02.13-14: re-design the topology among different db modules
2018.02.15: add a new file: app_basic.sol 0.01
2018.02.16: change the name app_basic.sol to db_apis.sol; add a new file: app_controller.sol 0.01
2018.02.17-18: add the mapping among parameter (bytes32) and its value (string) in app_controller.sol. Enable the operation of parsering and returning the string from/to the client 
2018.02.19: add two new files: test_database.sol; test_create_contract.sol
2018.02.20-21: test and modification on different db modules.
2018.02.24: add a new file db_user.sol
2018.02.22-25: start constructing the new way of "passing string" among contracts.
2018.02.26: add a new file plat_externalcontracts.sol
2018.02.27-03.01: re-construct the system as the currrent size of entire compiled bin (single) file is over 70KB, which leades to oversized error when deploying to the ethereum platform
2018.03.02-03.04: testing on db_database and db_node.f
2018.03.05: add a new file factory_basic.sol
2018.03.06: working on testing the db_database and db_node;
2018.03.07: creating db_node by integrating with db_database is ok by now
2018.03.08: chnage factory_basic.sol to db_factory.sol
2018.03.09-10: creating a DBProvider node and setting node parameters by DBApis are ok
2018.03.11: change file names: db_factory.sol->factory_base.sol, db_apis.sol->control_apis.sol
2018.03.12: add two files: control_info.sol and control_apis.sol
2018.03.13-15: work on testing zsc APIs with using Ethereum JS-APIs; to be continued...
2018.03.16: add a file: log_recorder.sol
2018.03.17-19: work on developing ZSC ControlApis based javascript apis used for web-client; work on dev. db_template;
2018.03.20-22: be compatible with Metamask now
2018.03.23-26: work on integrating web3.js apis, Metamask and zsc apis via web
2018.03.27: start developing the functionality of creating customized insurance template
2018.03.28: add two files web3js.js and userFunctions.js for showing examples of how to use web3js and zsc apis as well as Metamask at the web-client side
2018.03.29: add three files htmlFormat.js, zscTestLogin.html and zscTestMain.html
2018.03.30: change file name app_control.sol -> app_proxy.sol; add file basicFunctions.sol
2018.03.31: add two new file adm_base.sol and simulation_base.sol
2018.04.01: change the module name from simulation_base to db_simulator; add two new files adm_create_contract.php and adm_header.php
2018.04.02: add files adm_control_apis_adv.php, adm_configure_logrecorder.php, zscUser.js and zscElement.js
2018.04.01-03: add five files adm_show_log.php, db_staker.sol, wallet_base.sol, WebAdm/js/setupFunctions.js, WebAdm/js/createContract.js
2018.04.04: add two files zsc_html_modules.php, zsc_system_modules.php; change file name db_simulator.sol -> simulator_base.sol
2018.04.05: add file WebAdm/zsc_base.php, WebClient/zscHtml.js
2018.04.06-08: add three WebAdm/js/zsc_user_management.js, pos_block_pool.sol and pos_user_group.sol
2018.04.09-10: chang the key modifer only_delegat in order to support assigning different priorities to different kinds of contract objects
2018.04.11: add three files pos_block.sol, wallet_eth.sol, wallet_erc20.sol
```
