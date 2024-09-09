-- Importing
require("classes.filme")
require("functions.dao")

-- Creating
local screen1 = {
    filmFile = "archives/filme.txt",
    inputField = {active = nil, text = ""},  -- Para lidar com campos de entrada
    inputs = {
        nome = "",
        dataLancamento = "",
        produtora = "",
        diretor = "",
        receita = "",
        orcamento = ""
    },
    fields = {"Nome", "Data de Lançamento", "Produtora", "Diretor", "Receita", "Orçamento"},
    fieldPositions = {},  -- Armazenar as posições dos campos
    currentField = nil,  -- Nenhum campo ativo inicialmente
    completed = false,
    confirmButton = {x = 50, y = 350, width = 100, height = 30}  -- Posição do botão "Confirmar"
}

function screen1.load()
    love.window.setTitle("Tela 1")
    screen1.filme = nil

    -- Definir posições dos campos (x, y, width, height)
    for i = 1, #screen1.fields do
        table.insert(screen1.fieldPositions, {x = 200, y = 50 + (i * 30), width = 200, height = 25})
    end
end

function screen1.draw()
    -- Exibir campos de texto e capturar entrada do usuário
    for i, field in ipairs(screen1.fields) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(field .. ": ", 50, 50 + (i * 30), 100, "left")
        love.graphics.rectangle("line", 200, 50 + (i * 30), 200, 25)

        local value = screen1.inputs[field:lower()] or ""

        if screen1.currentField == i then
            love.graphics.printf(screen1.inputField.text, 210, 55 + (i * 30), 180, "left")
        else
            love.graphics.printf(value, 210, 55 + (i * 30), 180, "left")
        end
    end

    -- Botão de confirmar
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", screen1.confirmButton.x, screen1.confirmButton.y, screen1.confirmButton.width, screen1.confirmButton.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Confirmar", screen1.confirmButton.x, screen1.confirmButton.y + 5, screen1.confirmButton.width, "center")

    if screen1.completed then
        love.graphics.printf("Filme salvo!", 50, 400, 400, "left")
    end
end

function screen1.keypressed(key)
    if screen1.currentField then
        if key == "return" then
            -- Salvar valor do campo ativo
            screen1.inputs[screen1.fields[screen1.currentField]:lower()] = screen1.inputField.text
            screen1.inputField.text = ""
            screen1.currentField = nil  -- Nenhum campo ativo
        elseif key == "backspace" then
            -- Apagar o último caractere
            if #screen1.inputField.text > 0 then
                screen1.inputField.text = screen1.inputField.text:sub(1, -2)
            end
        end
    end
end

function screen1.textinput(t)
    if screen1.currentField then
        screen1.inputField.text = screen1.inputField.text .. t
    end
end

function screen1.mousepressed(x, y, button)
    if button == 1 then  -- Verificar se o botão esquerdo do mouse foi clicado
        local clickedInsideField = false

        -- Verificar se o clique foi em algum campo de texto
        for i, pos in ipairs(screen1.fieldPositions) do
            if x > pos.x and x < pos.x + pos.width and y > pos.y and y < pos.y + pos.height then
                -- Salvar o texto do campo anterior, se existir
                if screen1.currentField then
                    screen1.inputs[screen1.fields[screen1.currentField]:lower()] = screen1.inputField.text
                end

                -- Se o clique estiver dentro das coordenadas do campo, ativá-lo
                screen1.currentField = i
                screen1.inputField.text = screen1.inputs[screen1.fields[i]:lower()] or ""
                clickedInsideField = true
                break
            end
        end

        -- Se o clique não estiver em nenhum campo, desativar a edição
        if not clickedInsideField then
            -- Salvar o texto do campo anterior, se existir
            if screen1.currentField then
                screen1.inputs[screen1.fields[screen1.currentField]:lower()] = screen1.inputField.text
            end
            screen1.currentField = nil
            screen1.inputField.text = ""
        end

        -- Verificar se o botão "Confirmar" foi clicado
        if x > screen1.confirmButton.x and x < screen1.confirmButton.x + screen1.confirmButton.width and 
           y > screen1.confirmButton.y and y < screen1.confirmButton.y + screen1.confirmButton.height then
            -- Salvar o filme quando o botão for clicado
            local storagedFilm = newFilm({
                nome = screen1.inputs.nome,
                dataLancamento = screen1.inputs.dataLancamento,
                produtora = screen1.inputs.produtora,
                diretor = screen1.inputs.diretor,
                receita = screen1.inputs.receita,
                orcamento = screen1.inputs.orcamento
            })
            addInFile(screen1.filmFile, storagedFilm.getSerialized())
            screen1.completed = true
        end
    end
end

-- Returning
return screen1