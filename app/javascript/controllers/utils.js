export const url = {
  http: `http://${window.location.host}`,
};

export const getRequest = async (url) => {
  const res = await fetch(url);
  const data = await res.json();
  return data;
};

export const postRequest = async (url, method, formData) => {
  const res = await fetch(url, {
    method: method,
    headers: {},
    body: new FormData(formData),
  });
  const data = await res.json();
  return data;
};
