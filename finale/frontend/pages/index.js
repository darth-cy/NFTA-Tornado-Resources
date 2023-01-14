
import Script from "next/script";
import Interface from '../components/Interface.js';

const Index = () => {
    return (
        <div>
            <link rel="stylesheet" href="/css/bootstrap.min.css"></link>
            <Script src="/js/snarkjs.min.js" />
            <Interface />
        </div>
    )
};

export default Index;