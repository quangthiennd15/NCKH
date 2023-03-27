import React, { Component } from "react";
import Web3 from "web3";
import "./App.css";
import { CONTRACT_ABI, CONTRACT_ADDRESS } from "./config.js";

class App extends Component {
  componentWillMount() {
    this.loadBlockchainData();
  }

  async loadBlockchainData() {
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const web3 = new Web3(window.ethereum);
    const accounts = await web3.eth.getAccounts();
    this.setState({ account: accounts[0] });
    const manage = new web3.eth.Contract(CONTRACT_ABI, CONTRACT_ADDRESS);
    this.setState({ manage });
    const patent = await manage.methods
      .addPatient("1", "1", 1, "1", "1", "1", "1")
      .send({ from: accounts[0] });
    // const manager = await manage.methods
    //   .addManager("0x2A369aeb13C8cf5f8d0Cf32B70766c740D474B4E", "Thien")
    //   .send({ from: accounts[0] });
    // this.setState({ patent });
    // this.setState({ manager });
    // const infoman = await manage.methods
    //   .findManage("0x2A369aeb13C8cf5f8d0Cf32B70766c740D474B4E")
    //   .send({ from: accounts[0] });
    // const infoman1 = JSON.stringify(infoman);
    // this.setState({ infoman1 });

    const info = await manage.methods
      .findPatent("1")
      .send({ from: accounts[0] });
    this.setState(info);
    const infoman1 = JSON.stringify(info);
    this.setState({ infoman1 });
  }

  constructor(props) {
    super(props);
    this.state = { account: "", patent: "" };
  }

  render() {
    return (
      <div className="container">
        <h1>Hello, World!</h1>
        <p>Your account: {this.state.account}</p>
        {/* <p>{this.state.info}</p> */}
        <p>Info: {this.state.infoman1}</p>
      </div>
    );
  }
}

export default App;
