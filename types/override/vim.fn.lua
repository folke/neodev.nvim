return {
  ["vim.fn.expand"] = {
    params = {
      { name = "string", type = "string" },
      { name = "nosuf", type = "boolean", optional = true },
    },
    overload = {
      "fun(string:string, nosuf?:boolean, list:true):string[]",
    },
    ["return"] = {
      { type = "string" },
    },
  },
  ["vim.fn.sign_define"] = {
    overload = {
      "fun(name:string, dict?:table)",
    },
  },
}
