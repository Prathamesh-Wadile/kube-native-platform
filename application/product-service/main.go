package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
)

// Product defines the structure of our product data
type Product struct {
	ID          string   `json:"id"`
	Name        string   `json:"name"`
	Price       float64  `json:"price"`
	Keywords    []string `json:"keywords"`
}

func main() {
	// Logger configuration
	logger := log.New(os.Stdout, "[product-service] ", log.LstdFlags)

	// Handler for Health Check
	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]string{"status": "healthy", "service": "product-service"})
	})

	// Handler for Getting Products
	http.HandleFunc("/products", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		
		// Mock Data (In Phase 4 we can connect this to MongoDB)
		products := []Product{
			{ID: "1", Name: "Ergonomic Gaming Mouse", Price: 45.99, Keywords: []string{"gaming", "ergonomic", "led", "fast"}},
			{ID: "2", Name: "Mechanical Keyboard", Price: 89.50, Keywords: []string{"clicky", "rgb", "durable", "mechanical"}},
			{ID: "3", Name: "4K Monitor", Price: 299.00, Keywords: []string{"4k", "ips", "gaming", "hdr"}},
		}

		logger.Println("Serving product list")
		json.NewEncoder(w).Encode(products)
	})

	// Start Server
	port := ":8080"
	logger.Printf("Server starting on port %s", port)
	if err := http.ListenAndServe(port, nil); err != nil {
		logger.Fatal(err)
	}
}