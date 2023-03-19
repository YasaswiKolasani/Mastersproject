import React, { useState, useEffect} from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import Container from 'react-bootstrap/Container';
import { Form, FormGroup, Label, Input, Col, Button } from 'reactstrap';
import Row from 'react-bootstrap/Row';

const Homepage =({state})=> {

const [account,setAccount] = useState("");

useEffect(()=>{

    const getAccount=async()=>{
        const {web3}=state;
        const accounts = await web3.eth.getAccounts();
        console.log(accounts);
        setAccount(accounts[0]);
    }
    state.web3 && getAccount();
},[state, state.web3]);

const contractBalance = async()=> {
    const {contract} = state;
    const balance = await contract.methods.getbal().call({from:account});
}
return(
    <div>
        <Container>
        <br></br>
        <Row calss= "mt-1">
        
            <h3>
                <marquee behavior="scroll" direction="left" scrollamount="5" >
                   <b> <p color='red'>Your Account: {account}</p></b></marquee>
            </h3>
        </Row>
        <Container>
            
        </Container>
        </Container>
    </div>
    
    )
};



export default Homepage;