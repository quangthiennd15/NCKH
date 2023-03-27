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

    const info = await manage.methods.findPatent("1").call();
    this.setState(info);
  }

  constructor(props) {
    super(props);
    this.state = { account: "" };
  }

  render() {
    return (
      <div className="container">
        <h1>Hello, World!</h1>
        <p>Your account: {this.state.account}</p>
        <p>{this.state.info}</p>
      </div>
    );
  }
}

export default App;
