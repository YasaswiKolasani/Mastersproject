import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';

const Navigationbar = () => {
  return (
    <>
      <Navbar collapseOnSelect expand="md"  className="navbar navbar-expand-lg navbar-light bg-light">
        <Container fluid>
        <div className="navbar-brand">
       <i class="bi bi-mortarboard-fill" width="60" height="60"  ></i>
        </div>
          <Navbar.Brand ><b>Student Scholarship Management</b></Navbar.Brand>
          <Navbar.Toggle aria-controls="responsive-navbar-nav" />
          <Navbar.Collapse id="responsive-navbar-nav">
            <Nav className="me-auto">

          </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>

      
      
    </>
  );
};

export default Navigationbar;