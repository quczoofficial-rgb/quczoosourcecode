
const validateProduct = (data) => {
  const errors = {};

  if (!data.name || data.name.trim() === "") {
    errors.name = "Product name is required";
  }

  if (!data.category || data.category.trim() === "") {
    errors.category = "Product category is required";
  }

  if (data.price === undefined || data.price === null || data.price === "") {
    errors.price = "Product price is required";
  } else if (Number(data.price) < 0) {
    errors.price = "Price cannot be negative";
  }

  if (
    data.sellingPrice === undefined ||
    data.sellingPrice === null ||
    data.sellingPrice === ""
  ) {
    errors.sellingPrice = "Selling price is required";
  } else if (Number(data.sellingPrice) < 0) {
    errors.sellingPrice = "Selling price cannot be negative";
  }

  if (!data.unit || data.unit.trim() === "") {
    errors.unit = "Product unit is required";
  }

  if (data.stock === undefined || data.stock === null || data.stock === "") {
    errors.stock = "Stock is required";
  } else if (Number(data.stock) < 0) {
    errors.stock = "Stock cannot be negative";
  }

  return {
    isValid: Object.keys(errors).length === 0,
    errors,
  };
};

module.exports = validateProduct;