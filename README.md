# AXI4_LITE

  Project: AXI-Lite Master-Slave Interface

This design implements an **AXI4-Lite** communication interface with **five channels** between a Master and a Slave:

 AXI-Lite Channels:

1. **AW (Write Address Channel)** – Master sends address to which data will be written.
2. **W (Write Data Channel)** – Master sends actual data to be written.
3. **B (Write Response Channel)** – Slave responds with write status.
4. **AR (Read Address Channel)** – Master sends address from which data will be read.
5. **R (Read Data Channel)** – Slave returns data from the requested address.

---

 Testbench:

The testbench initiates multiple **read and write transactions** from the master to the slave, verifying:

* Correct data storage in slave's register file
* Proper handshakes for each channel
* Response signaling and reset handling

---

Let me know if you want a version with waveform viewer instructions or test coverage summary.
