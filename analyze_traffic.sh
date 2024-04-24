#!/bin/bash

# Bash Script to Analyze Network Traffic
declare -i totalpackets
declare -i http_packets
# Input: Path to the Wireshark pcap file
read pcap_path


# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.
    
totalpackets=$(tshark -r ${pcap_path} -Y "http || tls" | wc -l)
http_packets=$(tshark -r ${pcap_path} -Y "http" | wc -l)
tls_packets=$(tshark -r ${pcap_path} -Y " tls" | wc -l)


    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    echo "1. Total Packets: [$totalpackets]"
    echo "2. Protocols:"
    echo "   - HTTP: [$http_packets] packets"
    echo "   - HTTPS/TLS: [$tls_packets] packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    echo "$(tshark -r ${pcap_path} -Y "http || tls" -T fields -e ip.src | sort | uniq -c | sort -nr | head -5 | awk '{print "- " $2 ": " $1 " Packets"}')"
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
   echo "$(tshark -r ${pcap_path} -Y "http || tls" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -5 | awk '{print "- " $2 ": " $1 " Packets"}')"
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic



