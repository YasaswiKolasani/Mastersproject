import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import { Link, Route, Routes } from "react-router-dom";
import React, { useState, useEffect } from "react";
import Homepage from "../homepage/Homepage";
import getWeb3 from "../../getWeb3";
import Student from "../../contracts/Student.json";
const Navigationbar =()=> {
  const [state, setState] = useState({
    web3: null,
    contract: null,
  });

  useEffect(() => {
    const init = async () => {
      try {
        const web3 = await getWeb3();
        const networkId = await web3.eth.net.getId();

        const deployedNetwork = Student.networks[networkId];
        console.log("Contract Address:", deployedNetwork.address);
        const instance = new web3.eth.Contract(
          Student.abi,
          deployedNetwork && deployedNetwork.address
        );
        setState({ web3, contract: instance });
      } catch (error) {
        alert("Falied to load web3 or contract.");
        console.log(error);
      }
    };
    init();
  }, []);

  return (
    <>
      <Navbar collapseOnSelect expand="md"  className="navbar navbar-expand-lg navbar-light bg-success">
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

      <Routes>
        <Route exact path="/" element={<Homepage state={state} />} />
        <Route exact path="/home" element={<Homepage state={state} />} />
      </Routes>
      
    </>
  );
};

export default Navigationbar;