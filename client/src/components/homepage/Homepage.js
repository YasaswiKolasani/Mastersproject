import React, { useState, useEffect} from 'react';
import Form from 'react-bootstrap/Form';
import 'bootstrap/dist/css/bootstrap.min.css';
import Nav from 'react-bootstrap/Nav';
import {  Routes, Route, Link} from 'react-router-dom';

const Homepage =({state})=> {

const [account,setAccount] = useState("");
const [cbalance, setCBalance] = useState(0);
const [lwinner,setLwinner]=useState("No winner yet");

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
const winner =async()=>{

}
    return(
        <div>Hii from homepage

        </div>
    );
};



export default Homepage;