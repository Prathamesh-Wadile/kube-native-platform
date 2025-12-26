import React, { useState, useEffect } from 'react';

function App() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    // MOCK DATA: Simulating the Product Service response
    // In Phase 4, we will replace this with: fetch('/api/products')
    setProducts([
      {id: 1, name: "Ergonomic Gaming Mouse", price: 45.99},
      {id: 2, name: "Mechanical Keyboard", price: 89.50},
      {id: 3, name: "4K Monitor", price: 299.00}
    ]);
  }, []);

  return (
    <div className="App">
      <h1>🛍️ Kube-Native AI Shop</h1>
      <p>Powered by Kubernetes & Generative AI</p>
      
      <div className="product-list">
        {products.map(p => (
          <div key={p.id} className="card">
            <h3>{p.name}</h3>
            <p>${p.price}</p>
            <button onClick={() => alert(`[AI SERVICE] Generating description for: ${p.name}...`)}>
              ✨ Ask AI for Description
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;