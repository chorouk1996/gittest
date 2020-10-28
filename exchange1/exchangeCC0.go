/*
Copyright IBM Corp. 2016 All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

		 http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

import (
	"os"
	"fmt"
	"strconv"
	"log"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	"github.com/hyperledger/fabric-chaincode-go/shim"
)

type serverConfig struct {
	CCID    string
	Address string
}

type ExchangePlaceChaincode struct {
	contractapi.Contract
}

func (t *ExchangePlaceChaincode) Init(ctx contractapi.TransactionContextInterface, A string, Aval int, B string, Bval int) error {
	log.Print("ExchangePlace Init")
	log.Printf("Aval = %d, Bval = %d\n", Aval, Bval)

	// Write the state to the ledger
	err := ctx.GetStub().PutState(A, []byte(strconv.Itoa(Aval)))
	if err != nil {
		log.Printf("Error writing to ledger: key %s, value %d", A, Aval)
		return err
	}

	log.Printf("Success writing to ledger: key %s, value %d", A, Aval)

	err = ctx.GetStub().PutState(B, []byte(strconv.Itoa(Bval)))
	if err != nil {
		log.Printf("Error writing to ledger: key %s, value %d", B, Bval)
		return err
	}

	log.Printf("Success writing to ledger: key %s, value %d", B, Bval)
	return nil
}

// Transaction makes payment of X units from A to B
func (t *ExchangePlaceChaincode) Invoke(ctx contractapi.TransactionContextInterface, A string, B string, x int) error {
	log.Print("ExchangePlace Invoke")
	var Aval, Bval int // Asset holdings

	// Get the state from the ledger
	Avalbytes, err := ctx.GetStub().GetState(A)
	if err != nil {
		log.Printf("Failed to get state: key %s, Error: %s", A, err.Error())
		return fmt.Errorf("Failed to get state: %s", err.Error())
	}
	if Avalbytes == nil {
		return fmt.Errorf("Entity not found")
	}
	Aval, _ = strconv.Atoi(string(Avalbytes))

	Bvalbytes, err := ctx.GetStub().GetState(B)
	if err != nil {
		log.Printf("Failed to get state: key %s, Error: %s", B, err.Error())
		return fmt.Errorf("Failed to get state")
	}
	if Bvalbytes == nil {
		return fmt.Errorf("Entity not found")
	}
	Bval, _ = strconv.Atoi(string(Bvalbytes))

	Aval = Aval - x
	Bval = Bval + x
	log.Printf("Aval = %d, Bval = %d\n", Aval, Bval)

	// Write the state back to the ledger
	err = ctx.GetStub().PutState(A, []byte(strconv.Itoa(Aval)))
	if err != nil {
		log.Printf("Error writing to ledger: key %s, value %d", A, Aval)
		return err
	}
	log.Printf("Success writing to ledger: key %s, value %d", A, Aval)

	err = ctx.GetStub().PutState(B, []byte(strconv.Itoa(Bval)))
	if err != nil {
		log.Printf("Error writing to ledger: key %s, value %d", B, Bval)
		return err
	}
	log.Printf("Success writing to ledger: key %s, value %d", B, Bval)
	return nil
}

// Deletes an entity from state
func (t *ExchangePlaceChaincode) Delete(ctx contractapi.TransactionContextInterface, key string) error {
	log.Print("ExchangePlace Delete")
	// Delete the key from the state in ledger
	err := ctx.GetStub().DelState(key)
	if err != nil {
		log.Printf("Failed to delete state: %s", err.Error())
		return fmt.Errorf("Failed to delete state: %s", err.Error())
	}

	log.Printf("Success delete state: %s", err.Error())
	return nil
}

// query callback representing the query of a chaincode
func (t *ExchangePlaceChaincode) Query(ctx contractapi.TransactionContextInterface, key string) (string, error) {
	log.Print("ExchangePlace Query")

	// Get the state from the ledger
	Avalbytes, err := ctx.GetStub().GetState(key)
	if err != nil {
		log.Printf("Failed to get state: key %s, Error: %s", key, err.Error())
		jsonResp := "{\"Error\":\"Failed to get state for " + key + "\"}"
		return "", fmt.Errorf(jsonResp)
	}

	if Avalbytes == nil {
		jsonResp := "{\"Error\":\"Nil amount for " + key + "\"}"
		return "", fmt.Errorf(jsonResp)
	}

	log.Printf("Success: get state: key %s", key)

	jsonResp := "{\"Name\":\"" + key + "\",\"Amount\":\"" + string(Avalbytes) + "\"}"
	log.Printf("Query Response:%s\n", jsonResp)
	return string(Avalbytes), nil
}

func main() {
	log.Print("Begin creating chaincode")
	chaincode, err := contractapi.NewChaincode(new(ExchangePlaceChaincode))
	if err != nil {
		fmt.Printf("Error creating Simple chaincode: %s", err)
		return
	}
	log.Print("Successfully created chaincode from contractapi")

	config := serverConfig{
		CCID:    os.Getenv("CHAINCODE_ID"),
		Address: os.Getenv("CHAINCODE_SERVER_ADDRESS"),
	}

	server := &shim.ChaincodeServer{
		CCID:    config.CCID,
		Address: config.Address,
		CC:      chaincode,
		TLSProps: shim.TLSProperties{
			Disabled: true,
		},
	}

	log.Printf("chaincode server for chaincode ID: %s is will listen on %s", config.CCID, config.Address)

	if err := server.Start(); err != nil {
		fmt.Printf("error starting exchangecc chaincode: %s", err)
	}

}
