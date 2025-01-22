# Fertilizer-Recommendation-Engine-PROLOG

This project implements a Prolog-based expert system for fertilizer recommendations, helping farmers optimize agricultural practices. It uses logical inference to suggest suitable fertilizers, improving crop yield and sustainability. The backend integrates with an existing frontend to provide a complete agricultural decision-making solution.

**Note**: This is the initial setup, and the server currently only returns a "Hello, World!" message.

---

## Prerequisites

Before you can run the project locally, ensure you have the following installed:

1. **SWI-Prolog**: This project uses SWI-Prolog as the Prolog interpreter. You can download it from the official website:  
   [SWI-Prolog Downloads](https://www.swi-prolog.org/Download.html)

2. **A web browser**: To interact with the application through a browser, you'll need a web browser like Google Chrome, Firefox, or Safari.

---

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Programming-Sai/Fertilizer-Recommendation-Engine-PROLOG.git

   cd Fertilizer-Recommendation-Engine-PROLOG
   ```

2. **Ensure SWI-Prolog is installed**:
   - If you haven't already installed SWI-Prolog, follow the instructions on the [installation page](https://www.swi-prolog.org/Download.html) for your specific operating system.

---

## Running the Project Locally

### Step 1: Start the Prolog HTTP Server

1. **Open SWI-Prolog**:  
   Launch SWI-Prolog by running `swipl` in your terminal.

2. **Load the Prolog file**:  
   Load the main Prolog file (`hello_world_server.pl`) by running the following in the Prolog terminal:

   ```prolog
   [hello_world_server].
   ```

3. **Start the server**:  
   To start the HTTP server, run:

   ```prolog
   start.
   ```

   The server will start on port `8080`. You should see a message in the terminal indicating that the server is running.

4. **Access the application**:  
   Open your web browser and go to the following URL to interact with the application:

   ```
   http://localhost:8080
   ```

   You should see a message saying: "Hello, World Bitches!" as the root URL handler is currently defined to show this message.

---

### Step 2: Restarting the Server

- If you make changes to the Prolog code and want to restart the server, use the following command in the Prolog terminal:

  ```prolog
  restart.
  ```

  This will stop the server, reload the Prolog file, and restart the server with the new changes.

---

### Step 3: Stopping the Server

- To stop the server, you can run:

  ```prolog
  stop.
  ```

  This will stop the HTTP server on port `8080`.

---

### Step 4: Stopping the Entire Application

- To stop the entire applicatoin, you can run:

  ```prolog
  halt.
  ```

  This will end the `swipl` instance.

---

## How the System Works

- **Initial Setup**: The server is set up using SWI-Prolog's HTTP server library. Currently, when you visit the root URL (`http://localhost:8080`), it triggers the `say_hello/1` predicate, which simply returns the message "Hello, World Bitches!".
- **Future Updates**: In future updates, the system will integrate logical inference for fertilizer recommendations. For now, this setup serves as the basic structure for serving HTTP requests.
