actual_probs = [.947, .031, .022];
probs = [0,0,0];
tests = 25;
avg = 0;
test_runs = zeros(1,tests);
for j=1:tests
    for i=1:1000
        model = load_diagnosis();
        model = mcmc(model, 5, 1, i);
        probs(1) = sum(model{1}.samples == 0)/i;
        probs(2) = sum(model{1}.samples == 1)/i;
        probs(3) = sum(model{1}.samples == 2)/i;
        probs = probs / sum(probs);
        if abs(probs - actual_probs) < 0.01
             test_runs(j) = i;
             avg = avg + i;
             break;
        end
    end
end
test_runs
avg/tests

    