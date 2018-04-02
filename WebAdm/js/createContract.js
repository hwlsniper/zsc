

function cC_getContractAbi(contractName) {
    return " ";
}

function cC_getContractBin(contractName) {
    return "0x" + " "
}


function cC_showCreatingResult(type, elementID, text) {
    if (type == "text") {
        document.getElementById(elementID).innerText = text;
    } else if (type == "input") {
        var element = document.getElementById(elementID);
        if (element != null) element.value = text; 

        for (var i = 2; i < 4; ++i) {
            element = document.getElementById(elementID + i);
            if (element != null) element.value = text; 
        }
    }
}

function cC_createContract(contractName, parameter) {
    var logResult = "";
    var databin = cC_getContractBin(contractName);
    var greeterContract = web3.eth.contract(cC_getContractAbi(contractName)); 
    var account = web3.eth.accounts[0];
    console.log(account);
    var greeter = greeterContract.new(parameter, {account, data: databin, gas: 7500000}, function(e, contract){
        if(!e) {
            if(!contract.address) {
                logResult += "Send transactionHash: " + contract.transactionHash + "\nwaiting to be mined... ";
                cC_showCreatingResult("text", contractName + "Log", logResult);
            } else {
                logResult += "Mined! Address: " + contract.address + "\n";
                cC_showCreatingResult("text", contractName + "Adr", contractName + ": " + contract.address);
                cC_showCreatingResult("text", contractName + "Log", logResult);
                cC_showCreatingResult("input", contractName + "AdrPara", contract.address);

                var index = cC_ModuleName.length;
                cC_ModuleName[index] = contractName;
                cC_ModuleAdr[index] = contract.address;
            }
        } else {
            logResult += ": Error!! - " + e;
            cC_showCreatingResult("text", contractName + "Log", logResult);
        }
    })
}
 
function cC_setupContract(contractName, param) {
    cC_createContract(contractName, document.getElementById(param).value);
}  

