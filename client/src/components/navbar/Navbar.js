import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import { Link, Route, Routes } from "react-router-dom";
import React, { useState } from "react";
import {Container, Row, Col, Button} from "react-bootstrap";
import Homepage from "../homepage/Homepage";
import getWeb3 from "../../getWeb3";
import Student from "../../contracts/Student.json";
const Navigationbar =()=> {
  const [state, setState] = useState({
    web3: null,
    contract: null,
    account: null
  });
  const [metamaskBusy, setMetamaskBusy] = useState(false);
  const [account, setAccount] = useState("");

  const init = async () => {
      setMetamaskBusy(true);
      try {
        const web3 = await getWeb3();
        const networkId = await web3.eth.net.getId();
        const accounts = await web3.eth.getAccounts();
        setAccount(accounts[0]);
        console.log("Connected to Metamask");

        const deployedNetwork = Student.networks[networkId];
        console.log("Contract Address:", deployedNetwork.address);
        const instance = new web3.eth.Contract(
          Student.abi,
          deployedNetwork && deployedNetwork.address
        );
        setState({ web3, contract: instance, account: accounts[0] });
      } catch (error) {
        alert("Falied to load web3 or contract. Choose proper network in the metamask account");
        console.log(error);
      }
      setMetamaskBusy(false);
    };

  return (
    <>
      <Navbar collapseOnSelect expand="md"  className="navbar navbar-expand-lg navbar-light bg-primary">
        <Container fluid>
        <div className="navbar-brand">
       <i className="bi bi-mortarboard-fill" width="60" height="60"  ></i>
        </div>
          <Navbar.Brand ><b>Student Scholarship Management</b></Navbar.Brand>
          <Navbar.Toggle aria-controls="responsive-navbar-nav" />
          <Navbar.Collapse id="responsive-navbar-nav">
            <Nav className="me-auto">
                <Nav.Link as={Link} to="/home">Home</Nav.Link>
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>
      <br></br>
      <Row>
         {account && <><Col></Col><Col md={5}><Button variant='secondary'><h5><b>Your Account: {account}</b></h5></Button></Col><Col></Col></>}
          {
           !account && 
            <div>
                <Row>
                    <Col md={3}></Col>
                    <Col md={6}>
                        <Button variant="warning" size="lg" onClick={init}>{metamaskBusy ? "Connecting..." : "Connect to Metamask"}</Button>
                    </Col>
                    <Col md={3}></Col>
                </Row>
                <br></br>
                <span style={{ color: 'red' }}>*{"  "}</span><span><i>You should connect to metamask wallet to access this application</i></span>
            </div>
          }
        </Row>
      <Routes>
        <Route exact path="/" element={<Homepage state={state} />} />
        <Route exact path="/home" element={<Homepage state={state} />} />
      </Routes>
      
    </>
  );
};

export default Navigationbar;